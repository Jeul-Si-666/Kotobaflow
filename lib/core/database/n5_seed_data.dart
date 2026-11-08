import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'app_database.dart';

/// Loads the N5 vocabulary from the bundled OpenJLPT SQLite database.
Future<List<VocabulariesCompanion>> loadOpenJlptVocabularies() async {
  final database = await _openOpenJlptDatabase();
  try {
    final rows = database.select(
      "SELECT id, word, reading, romaji, meanings, level, pos, examples "
      "FROM vocab WHERE level = 'N5' ORDER BY id",
    );
    return rows.map(_toVocabularyCompanion).toList();
  } finally {
    database.close();
  }
}

Future<Database> _openOpenJlptDatabase() async {
  final dbFolder = await getApplicationSupportDirectory();
  final databaseFile = File(p.join(dbFolder.path, 'openjlpt.sqlite'));
  final asset = await rootBundle.load('lib/core/database/openjlpt.sqlite');
  await databaseFile.writeAsBytes(asset.buffer.asUint8List(), flush: true);
  return sqlite3.open(databaseFile.path, mode: OpenMode.readOnly);
}

VocabulariesCompanion _toVocabularyCompanion(Row row) {
  final word = row['word'] as String;
  final reading = row['reading'] as String;
  final partsOfSpeech = _decodeList(row['pos'] as String);
  final examples = _decodeList(row['examples'] as String);
  final firstExample = examples.isNotEmpty && examples.first is Map
      ? examples.first as Map<String, dynamic>
      : null;

  return VocabulariesCompanion.insert(
    id: row['id'] as String,
    kanji: Value(word == reading ? null : word),
    hiragana: reading,
    romaji: Value(row['romaji'] as String),
    meaning: _decodeList(row['meanings'] as String).join(', '),
    wordType: _wordTypeFromPartsOfSpeech(partsOfSpeech),
    verbGroup: Value(_verbGroupFromPartsOfSpeech(partsOfSpeech)),
    exampleJp: Value(firstExample?['ja'] as String?),
    exampleId: Value(firstExample?['en'] as String?),
    jlptLevel: row['level'] as String,
  );
}

List<dynamic> _decodeList(String value) {
  final decoded = jsonDecode(value);
  return decoded is List<dynamic> ? decoded : const [];
}

String _wordTypeFromPartsOfSpeech(List<dynamic> partsOfSpeech) {
  if (partsOfSpeech.any((part) => part.toString().startsWith('v'))) {
    return 'Verb';
  }
  if (partsOfSpeech.any((part) => part == 'adj-i')) return 'Adjective-i';
  if (partsOfSpeech.any((part) => part == 'adj-na')) return 'Adjective-na';
  if (partsOfSpeech.any((part) => part == 'adv')) return 'Adverb';
  return 'Noun';
}

String? _verbGroupFromPartsOfSpeech(List<dynamic> partsOfSpeech) {
  final verb = partsOfSpeech.cast<String?>().firstWhere(
    (part) => part != null && part.startsWith('v'),
    orElse: () => null,
  );
  if (verb == null) return null;
  if (verb == 'v1') return 'Ichidan';
  if (verb.startsWith('v5')) return 'Godan';
  return 'Irregular';
}

/// Initial curated JLPT N5 vocabulary dataset for offline-first bootstrapping.
///
/// Contains fundamental nouns, verbs with verb groups (Godan/Ichidan/Irregular),
/// i-adjectives, na-adjectives, adverbs, and expressions with example sentences.
final List<VocabulariesCompanion> n5SeedVocabularies = [
  // ── Verbs (Group 2 - Ichidan) ──────────────────────────────────────────────
  VocabulariesCompanion.insert(
    id: 'n5_0001',
    kanji: Value('食べる'),
    hiragana: 'たべる',
    romaji: Value('taberu'),
    meaning: 'Makan',
    wordType: 'Verb',
    verbGroup: Value('Group 2 (Ichidan)'),
    exampleJp: Value('毎朝パンを食べます。'),
    exampleId: Value('Setiap pagi saya makan roti.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0002',
    kanji: Value('見る'),
    hiragana: 'みる',
    romaji: Value('miru'),
    meaning: 'Melihat / Menonton',
    wordType: 'Verb',
    verbGroup: Value('Group 2 (Ichidan)'),
    exampleJp: Value('夜に映画を見ます。'),
    exampleId: Value('Saya menonton film di malam hari.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0003',
    kanji: Value('起きる'),
    hiragana: 'おきる',
    romaji: Value('okiru'),
    meaning: 'Bangun',
    wordType: 'Verb',
    verbGroup: Value('Group 2 (Ichidan)'),
    exampleJp: Value('毎朝六時に起きます。'),
    exampleId: Value('Setiap pagi saya bangun pukul enam.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0004',
    kanji: Value('寝る'),
    hiragana: 'ねる',
    romaji: Value('neru'),
    meaning: 'Tidur',
    wordType: 'Verb',
    verbGroup: Value('Group 2 (Ichidan)'),
    exampleJp: Value('十一時に寝ます。'),
    exampleId: Value('Saya tidur pukul sebelas.'),
    jlptLevel: 'N5',
  ),

  // ── Verbs (Group 1 - Godan) ────────────────────────────────────────────────
  VocabulariesCompanion.insert(
    id: 'n5_0005',
    kanji: Value('飲む'),
    hiragana: 'のむ',
    romaji: Value('nomu'),
    meaning: 'Minum',
    wordType: 'Verb',
    verbGroup: Value('Group 1 (Godan)'),
    exampleJp: Value('お水を飲みます。'),
    exampleId: Value('Saya minum air putih.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0006',
    kanji: Value('行く'),
    hiragana: 'いく',
    romaji: Value('iku'),
    meaning: 'Pergi',
    wordType: 'Verb',
    verbGroup: Value('Group 1 (Godan)'),
    exampleJp: Value('明日学校へ行きます。'),
    exampleId: Value('Besok saya pergi ke sekolah.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0007',
    kanji: Value('話す'),
    hiragana: 'はなす',
    romaji: Value('hanasu'),
    meaning: 'Berbicara',
    wordType: 'Verb',
    verbGroup: Value('Group 1 (Godan)'),
    exampleJp: Value('日本語で話しましょう。'),
    exampleId: Value('Ayo berbicara dalam bahasa Jepang.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0008',
    kanji: Value('聞く'),
    hiragana: 'きく',
    romaji: Value('kiku'),
    meaning: 'Mendengar / Bertanya',
    wordType: 'Verb',
    verbGroup: Value('Group 1 (Godan)'),
    exampleJp: Value('先生の話を聞きます。'),
    exampleId: Value('Saya mendengarkan penjelasan guru.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0009',
    kanji: Value('読む'),
    hiragana: 'よむ',
    romaji: Value('yomu'),
    meaning: 'Membaca',
    wordType: 'Verb',
    verbGroup: Value('Group 1 (Godan)'),
    exampleJp: Value('図書館で本を読みます。'),
    exampleId: Value('Saya membaca buku di perpustakaan.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0010',
    kanji: Value('書く'),
    hiragana: 'かく',
    romaji: Value('kaku'),
    meaning: 'Menulis',
    wordType: 'Verb',
    verbGroup: Value('Group 1 (Godan)'),
    exampleJp: Value('ノートに漢字を書きます。'),
    exampleId: Value('Saya menulis kanji di buku catatan.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0011',
    kanji: Value('買う'),
    hiragana: 'かう',
    romaji: Value('kau'),
    meaning: 'Membeli',
    wordType: 'Verb',
    verbGroup: Value('Group 1 (Godan)'),
    exampleJp: Value('コンビニでお弁当を買いました。'),
    exampleId: Value('Saya membeli bekal di minimarket.'),
    jlptLevel: 'N5',
  ),

  // ── Verbs (Group 3 - Irregular) ───────────────────────────────────────────
  VocabulariesCompanion.insert(
    id: 'n5_0012',
    kanji: Value('来る'),
    hiragana: 'くる',
    romaji: Value('kuru'),
    meaning: 'Datang',
    wordType: 'Verb',
    verbGroup: Value('Group 3 (Irregular)'),
    exampleJp: Value('友達が家にきます。'),
    exampleId: Value('Teman datang ke rumah saya.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0013',
    kanji: Value(null),
    hiragana: 'する',
    romaji: Value('suru'),
    meaning: 'Melakukan',
    wordType: 'Verb',
    verbGroup: Value('Group 3 (Irregular)'),
    exampleJp: Value('宿題をします。'),
    exampleId: Value('Saya mengerjakan pekerjaan rumah.'),
    jlptLevel: 'N5',
  ),

  // ── Nouns ──────────────────────────────────────────────────────────────────
  VocabulariesCompanion.insert(
    id: 'n5_0014',
    kanji: Value('本'),
    hiragana: 'ほん',
    romaji: Value('hon'),
    meaning: 'Buku',
    wordType: 'Noun',
    exampleJp: Value('面白い本です。'),
    exampleId: Value('Buku yang menarik.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0015',
    kanji: Value('水'),
    hiragana: 'みず',
    romaji: Value('mizu'),
    meaning: 'Air',
    wordType: 'Noun',
    exampleJp: Value('冷たい水をください。'),
    exampleId: Value('Tolong beri air dingin.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0016',
    kanji: Value('学校'),
    hiragana: 'がっこう',
    romaji: Value('gakkou'),
    meaning: 'Sekolah',
    wordType: 'Noun',
    exampleJp: Value('学校は駅から近いです。'),
    exampleId: Value('Sekolah dekat dari stasiun.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0017',
    kanji: Value('友達'),
    hiragana: 'ともだち',
    romaji: Value('tomodachi'),
    meaning: 'Teman',
    wordType: 'Noun',
    exampleJp: Value('友達と遊びました。'),
    exampleId: Value('Saya bermain bersama teman.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0018',
    kanji: Value('猫'),
    hiragana: 'ねこ',
    romaji: Value('neko'),
    meaning: 'Kucing',
    wordType: 'Noun',
    exampleJp: Value('可愛い猫がいます。'),
    exampleId: Value('Ada kucing yang lucu.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0019',
    kanji: Value('犬'),
    hiragana: 'いぬ',
    romaji: Value('inu'),
    meaning: 'Anjing',
    wordType: 'Noun',
    exampleJp: Value('公園で犬を散歩させます。'),
    exampleId: Value('Saya membawa anjing berjalan-jalan di taman.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0020',
    kanji: Value('車'),
    hiragana: 'くるま',
    romaji: Value('kuruma'),
    meaning: 'Mobil',
    wordType: 'Noun',
    exampleJp: Value('新しい車を買いました。'),
    exampleId: Value('Saya membeli mobil baru.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0021',
    kanji: Value('時間'),
    hiragana: 'じかん',
    romaji: Value('jikan'),
    meaning: 'Waktu / Jam',
    wordType: 'Noun',
    exampleJp: Value('時間がありません。'),
    exampleId: Value('Tidak ada waktu.'),
    jlptLevel: 'N5',
  ),

  // ── Adjectives (i-adjective) ───────────────────────────────────────────────
  VocabulariesCompanion.insert(
    id: 'n5_0022',
    kanji: Value('大きい'),
    hiragana: 'おおきい',
    romaji: Value('ookii'),
    meaning: 'Besar',
    wordType: 'Adjective-i',
    exampleJp: Value('大きい家ですね。'),
    exampleId: Value('Rumah yang besar ya.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0023',
    kanji: Value('小さい'),
    hiragana: 'ちいさい',
    romaji: Value('chiisai'),
    meaning: 'Kecil',
    wordType: 'Adjective-i',
    exampleJp: Value('小さい鳥が飛んでいます。'),
    exampleId: Value('Burung kecil sedang terbang.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0024',
    kanji: Value('高い'),
    hiragana: 'たかい',
    romaji: Value('takai'),
    meaning: 'Tinggi / Mahal',
    wordType: 'Adjective-i',
    exampleJp: Value('富士山は高い山です。'),
    exampleId: Value('Gunung Fuji adalah gunung yang tinggi.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0025',
    kanji: Value('安い'),
    hiragana: 'やすい',
    romaji: Value('yasui'),
    meaning: 'Murah',
    wordType: 'Adjective-i',
    exampleJp: Value('このリンゴはとても安いです。'),
    exampleId: Value('Apel ini sangat murah.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0026',
    kanji: Value('新しい'),
    hiragana: 'あたらしい',
    romaji: Value('atarashii'),
    meaning: 'Baru',
    wordType: 'Adjective-i',
    exampleJp: Value('新しい靴を履きました。'),
    exampleId: Value('Saya memakai sepatu baru.'),
    jlptLevel: 'N5',
  ),

  // ── Adjectives (na-adjective) ──────────────────────────────────────────────
  VocabulariesCompanion.insert(
    id: 'n5_0027',
    kanji: Value('静か'),
    hiragana: 'しずか',
    romaji: Value('shizuka'),
    meaning: 'Tenang / Sunyi',
    wordType: 'Adjective-na',
    exampleJp: Value('夜の部屋はとても静かです。'),
    exampleId: Value('Kamar di malam hari sangat sunyi.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0028',
    kanji: Value('元気'),
    hiragana: 'げんき',
    romaji: Value('genki'),
    meaning: 'Sehat / Bersemangat',
    wordType: 'Adjective-na',
    exampleJp: Value('お元気ですか。'),
    exampleId: Value('Apakah Anda sehat?'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0029',
    kanji: Value('親切'),
    hiragana: 'しんせつ',
    romaji: Value('shinsetsu'),
    meaning: 'Ramah / Baik hati',
    wordType: 'Adjective-na',
    exampleJp: Value('親切な人に助けられました。'),
    exampleId: Value('Saya ditolong oleh orang yang baik hati.'),
    jlptLevel: 'N5',
  ),

  // ── Adverbs & Expressions ──────────────────────────────────────────────────
  VocabulariesCompanion.insert(
    id: 'n5_0030',
    kanji: Value(null),
    hiragana: 'いつも',
    romaji: Value('itsumo'),
    meaning: 'Selalu',
    wordType: 'Adverb',
    exampleJp: Value('彼はいつも元気です。'),
    exampleId: Value('Dia selalu bersemangat.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0031',
    kanji: Value(null),
    hiragana: 'たくさん',
    romaji: Value('takusan'),
    meaning: 'Banyak',
    wordType: 'Adverb',
    exampleJp: Value('野菜をたくさん食べました。'),
    exampleId: Value('Saya makan banyak sayur.'),
    jlptLevel: 'N5',
  ),
  VocabulariesCompanion.insert(
    id: 'n5_0032',
    kanji: Value(null),
    hiragana: 'ありがとう',
    romaji: Value('arigatou'),
    meaning: 'Terima kasih',
    wordType: 'Expression',
    exampleJp: Value('手伝ってくれてありがとう。'),
    exampleId: Value('Terima kasih sudah membantu.'),
    jlptLevel: 'N5',
  ),
];
