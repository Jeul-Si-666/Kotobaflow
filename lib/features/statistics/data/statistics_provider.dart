import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../core/database/app_database.dart';

/// Data model representing overall learning analytics per PRD FR-06.
class LearningAnalyticsData {
  final int totalVocabCount;
  final int totalStudiedCount;
  final int matureCount;
  final int learningCount;
  final int reviewCount;
  final int totalCorrectAnswers;
  final int totalWrongAnswers;
  final int streakDays;
  final int totalStudyDurationMinutes;
  final List<DailyActivity> recentActivities;
  final List<Vocabulary> weakVocabularies;

  const LearningAnalyticsData({
    this.totalVocabCount = 0,
    this.totalStudiedCount = 0,
    this.matureCount = 0,
    this.learningCount = 0,
    this.reviewCount = 0,
    this.totalCorrectAnswers = 0,
    this.totalWrongAnswers = 0,
    this.streakDays = 0,
    this.totalStudyDurationMinutes = 0,
    this.recentActivities = const [],
    this.weakVocabularies = const [],
  });

  int get unstudiedCount =>
      (totalVocabCount - totalStudiedCount).clamp(0, totalVocabCount);

  int get totalAttempts => totalCorrectAnswers + totalWrongAnswers;

  double get overallAccuracy =>
      totalAttempts > 0 ? (totalCorrectAnswers / totalAttempts) * 100 : 0.0;
}

/// Provider computing learning analytics from SQLite tables.
final statisticsProvider = FutureProvider.autoDispose<LearningAnalyticsData>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);

  // 1. Vocabulary comes from the bundled OpenJLPT database.
  final openJlpt = await _openOpenJlptDatabase();
  final totalVocab =
      openJlpt
              .select("SELECT COUNT(*) AS count FROM vocab WHERE level = 'N5'")
              .first['count']
          as int;

  // 2. Learning progresses breakdown
  final allProgress = await db.select(db.learningProgresses).get();

  final uniqueStudiedVocabIds = allProgress.map((p) => p.vocabularyId).toSet();
  final totalStudied = uniqueStudiedVocabIds.length;

  var mature = 0;
  var learning = 0;
  var review = 0;

  for (final p in allProgress) {
    if (p.status == 'mature') {
      mature++;
    } else if (p.status == 'learning') {
      learning++;
    } else if (p.status == 'review' || p.status == 'relearning') {
      review++;
    }
  }

  // 3. Daily activities and streak
  final activities =
      await (db.select(db.dailyActivities)
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
            ..limit(7))
          .get();

  var totalCorrect = 0;
  var totalWrong = 0;
  var totalSeconds = 0;

  for (final a in activities) {
    totalCorrect += a.correctAnswers;
    totalWrong += a.wrongAnswers;
    totalSeconds += a.studyDurationSeconds;
  }

  final streak = activities.isNotEmpty && activities.first.wordsStudied > 0
      ? activities.length
      : 0;

  // 4. Identify weak vocabularies (where wrong_count > correct_count or status == 'relearning')
  final weakProgress = allProgress.where(
    (p) => p.wrongCount > p.correctCount || p.status == 'relearning',
  );
  final weakIds = weakProgress.map((p) => p.vocabularyId).toSet();

  final weakVocab = weakIds.isNotEmpty
      ? _readWeakOpenJlptVocabularies(openJlpt, weakIds)
      : <Vocabulary>[];

  openJlpt.close();

  return LearningAnalyticsData(
    totalVocabCount: totalVocab,
    totalStudiedCount: totalStudied,
    matureCount: mature,
    learningCount: learning,
    reviewCount: review,
    totalCorrectAnswers: totalCorrect,
    totalWrongAnswers: totalWrong,
    streakDays: streak,
    totalStudyDurationMinutes: (totalSeconds / 60).round(),
    recentActivities: activities,
    weakVocabularies: weakVocab,
  );
});

Future<Database> _openOpenJlptDatabase() async {
  final dbFolder = await getApplicationSupportDirectory();
  final databaseFile = File(p.join(dbFolder.path, 'openjlpt.sqlite'));
  final asset = await rootBundle.load('lib/core/database/openjlpt.sqlite');
  await databaseFile.writeAsBytes(asset.buffer.asUint8List(), flush: true);

  return sqlite3.open(databaseFile.path, mode: OpenMode.readOnly);
}

List<Vocabulary> _readWeakOpenJlptVocabularies(
  Database database,
  Set<String> vocabularyIds,
) {
  final placeholders = List.filled(vocabularyIds.length, '?').join(', ');
  final rows = database.select(
    "SELECT id, word, reading, romaji, meanings, level, pos "
    "FROM vocab WHERE level = 'N5' AND id IN ($placeholders)",
    vocabularyIds.toList(),
  );

  return rows.map((row) {
    final meanings = jsonDecode(row['meanings'] as String) as List<dynamic>;
    final partsOfSpeech = jsonDecode(row['pos'] as String) as List<dynamic>;

    return Vocabulary(
      id: row['id'] as String,
      kanji: row['word'] as String,
      hiragana: row['reading'] as String,
      romaji: row['romaji'] as String,
      meaning: meanings.join(', '),
      wordType: _wordTypeFromPartsOfSpeech(partsOfSpeech),
      jlptLevel: row['level'] as String,
      isFavorite: false,
    );
  }).toList();
}

String _wordTypeFromPartsOfSpeech(List<dynamic> partsOfSpeech) {
  if (partsOfSpeech.any((part) => part.toString().startsWith('v'))) {
    return 'Verb';
  }
  if (partsOfSpeech.any((part) => part == 'adj-i')) return 'Adjective-i';
  if (partsOfSpeech.any((part) => part == 'adj-na')) return 'Adjective-na';
  return 'Noun';
}
