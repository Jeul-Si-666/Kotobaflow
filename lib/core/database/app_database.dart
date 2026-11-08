import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'n5_seed_data.dart';

part 'app_database.g.dart';

// ── Tables ────────────────────────────────────────────────────────────────────

/// All N5 (and future N4–N1) vocabulary entries.
class Vocabularies extends Table {
  TextColumn get id => text()(); // e.g. 'n5_0001'
  TextColumn get kanji => text().nullable()();
  TextColumn get hiragana => text()();
  TextColumn get romaji => text().nullable()();
  TextColumn get meaning => text()();
  TextColumn get wordType => text()();
  TextColumn get verbGroup => text().nullable()();
  TextColumn get exampleJp => text().nullable()();
  TextColumn get exampleId => text().nullable()();
  TextColumn get audioPath => text().nullable()();
  TextColumn get jlptLevel => text()(); // 'N5', 'N4', …
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Per-vocabulary, per-direction learning progress.
///
/// [direction] is either [LearningDirection.jaToId] or [LearningDirection.idToJa].
/// Japanese → Indonesian and Indonesian → Japanese are tracked separately
/// because a learner may recognise a word but not be able to recall it.
class LearningProgresses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get vocabularyId => text().references(Vocabularies, #id)();
  TextColumn get direction => text()(); // 'ja_to_id' | 'id_to_ja'
  TextColumn get status => text().withDefault(const Constant('new'))();
  IntColumn get repetitions => integer().withDefault(const Constant(0))();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get wrongCount => integer().withDefault(const Constant(0))();
  TextColumn get nextReviewAt => text().nullable()(); // ISO-8601 string
  TextColumn get lastReviewedAt => text().nullable()(); // ISO-8601 string
}

/// Individual quiz / flashcard answer attempts.
class QuizAttempts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get vocabularyId => text().references(Vocabularies, #id)();
  TextColumn get questionType => text()(); // 'multiple_choice' | 'typing' | …
  TextColumn get userAnswer => text()();
  BoolColumn get isCorrect => boolean()();
  TextColumn get attemptedAt => text()(); // ISO-8601 string
}

/// Aggregated learning activity per calendar day.
class DailyActivities extends Table {
  TextColumn get date => text()(); // e.g. '2026-11-08'
  IntColumn get wordsStudied => integer().withDefault(const Constant(0))();
  IntColumn get correctAnswers => integer().withDefault(const Constant(0))();
  IntColumn get wrongAnswers => integer().withDefault(const Constant(0))();
  IntColumn get studyDurationSeconds =>
      integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {date};
}

// ── Database ──────────────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [Vocabularies, LearningProgresses, QuizAttempts, DailyActivities],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await batch((b) {
        b.insertAll(vocabularies, n5SeedVocabularies);
      });
    },
    beforeOpen: (details) async {
      final existing = await select(vocabularies).get();
      if (existing.length < n5SeedVocabularies.length) {
        final existingIds = existing.map((v) => v.id).toSet();
        final missing = n5SeedVocabularies
            .where((v) => !existingIds.contains(v.id.value))
            .toList();
        if (missing.isNotEmpty) {
          await batch((b) {
            b.insertAll(vocabularies, missing);
          });
        }
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    if (!await dbFolder.exists()) {
      await dbFolder.create(recursive: true);
    }
    final file = File(p.join(dbFolder.path, 'kotobaflow.db'));
    return NativeDatabase.createInBackground(file);
  });
}

// ── Riverpod Provider ─────────────────────────────────────────────────────────

/// Global database provider. Dispose closes the database connection.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
