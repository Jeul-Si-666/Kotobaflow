// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VocabulariesTable extends Vocabularies
    with TableInfo<$VocabulariesTable, Vocabulary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabulariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kanjiMeta = const VerificationMeta('kanji');
  @override
  late final GeneratedColumn<String> kanji = GeneratedColumn<String>(
    'kanji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hiraganaMeta = const VerificationMeta(
    'hiragana',
  );
  @override
  late final GeneratedColumn<String> hiragana = GeneratedColumn<String>(
    'hiragana',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _romajiMeta = const VerificationMeta('romaji');
  @override
  late final GeneratedColumn<String> romaji = GeneratedColumn<String>(
    'romaji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordTypeMeta = const VerificationMeta(
    'wordType',
  );
  @override
  late final GeneratedColumn<String> wordType = GeneratedColumn<String>(
    'word_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verbGroupMeta = const VerificationMeta(
    'verbGroup',
  );
  @override
  late final GeneratedColumn<String> verbGroup = GeneratedColumn<String>(
    'verb_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exampleJpMeta = const VerificationMeta(
    'exampleJp',
  );
  @override
  late final GeneratedColumn<String> exampleJp = GeneratedColumn<String>(
    'example_jp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exampleIdMeta = const VerificationMeta(
    'exampleId',
  );
  @override
  late final GeneratedColumn<String> exampleId = GeneratedColumn<String>(
    'example_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioPathMeta = const VerificationMeta(
    'audioPath',
  );
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
    'audio_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jlptLevelMeta = const VerificationMeta(
    'jlptLevel',
  );
  @override
  late final GeneratedColumn<String> jlptLevel = GeneratedColumn<String>(
    'jlpt_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kanji,
    hiragana,
    romaji,
    meaning,
    wordType,
    verbGroup,
    exampleJp,
    exampleId,
    audioPath,
    jlptLevel,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabularies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vocabulary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kanji')) {
      context.handle(
        _kanjiMeta,
        kanji.isAcceptableOrUnknown(data['kanji']!, _kanjiMeta),
      );
    }
    if (data.containsKey('hiragana')) {
      context.handle(
        _hiraganaMeta,
        hiragana.isAcceptableOrUnknown(data['hiragana']!, _hiraganaMeta),
      );
    } else if (isInserting) {
      context.missing(_hiraganaMeta);
    }
    if (data.containsKey('romaji')) {
      context.handle(
        _romajiMeta,
        romaji.isAcceptableOrUnknown(data['romaji']!, _romajiMeta),
      );
    }
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('word_type')) {
      context.handle(
        _wordTypeMeta,
        wordType.isAcceptableOrUnknown(data['word_type']!, _wordTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_wordTypeMeta);
    }
    if (data.containsKey('verb_group')) {
      context.handle(
        _verbGroupMeta,
        verbGroup.isAcceptableOrUnknown(data['verb_group']!, _verbGroupMeta),
      );
    }
    if (data.containsKey('example_jp')) {
      context.handle(
        _exampleJpMeta,
        exampleJp.isAcceptableOrUnknown(data['example_jp']!, _exampleJpMeta),
      );
    }
    if (data.containsKey('example_id')) {
      context.handle(
        _exampleIdMeta,
        exampleId.isAcceptableOrUnknown(data['example_id']!, _exampleIdMeta),
      );
    }
    if (data.containsKey('audio_path')) {
      context.handle(
        _audioPathMeta,
        audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta),
      );
    }
    if (data.containsKey('jlpt_level')) {
      context.handle(
        _jlptLevelMeta,
        jlptLevel.isAcceptableOrUnknown(data['jlpt_level']!, _jlptLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_jlptLevelMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vocabulary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vocabulary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kanji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kanji'],
      ),
      hiragana: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hiragana'],
      )!,
      romaji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}romaji'],
      ),
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      )!,
      wordType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_type'],
      )!,
      verbGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verb_group'],
      ),
      exampleJp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_jp'],
      ),
      exampleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_id'],
      ),
      audioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_path'],
      ),
      jlptLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jlpt_level'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
    );
  }

  @override
  $VocabulariesTable createAlias(String alias) {
    return $VocabulariesTable(attachedDatabase, alias);
  }
}

class Vocabulary extends DataClass implements Insertable<Vocabulary> {
  final String id;
  final String? kanji;
  final String hiragana;
  final String? romaji;
  final String meaning;
  final String wordType;
  final String? verbGroup;
  final String? exampleJp;
  final String? exampleId;
  final String? audioPath;
  final String jlptLevel;
  final bool isFavorite;
  const Vocabulary({
    required this.id,
    this.kanji,
    required this.hiragana,
    this.romaji,
    required this.meaning,
    required this.wordType,
    this.verbGroup,
    this.exampleJp,
    this.exampleId,
    this.audioPath,
    required this.jlptLevel,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || kanji != null) {
      map['kanji'] = Variable<String>(kanji);
    }
    map['hiragana'] = Variable<String>(hiragana);
    if (!nullToAbsent || romaji != null) {
      map['romaji'] = Variable<String>(romaji);
    }
    map['meaning'] = Variable<String>(meaning);
    map['word_type'] = Variable<String>(wordType);
    if (!nullToAbsent || verbGroup != null) {
      map['verb_group'] = Variable<String>(verbGroup);
    }
    if (!nullToAbsent || exampleJp != null) {
      map['example_jp'] = Variable<String>(exampleJp);
    }
    if (!nullToAbsent || exampleId != null) {
      map['example_id'] = Variable<String>(exampleId);
    }
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    map['jlpt_level'] = Variable<String>(jlptLevel);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  VocabulariesCompanion toCompanion(bool nullToAbsent) {
    return VocabulariesCompanion(
      id: Value(id),
      kanji: kanji == null && nullToAbsent
          ? const Value.absent()
          : Value(kanji),
      hiragana: Value(hiragana),
      romaji: romaji == null && nullToAbsent
          ? const Value.absent()
          : Value(romaji),
      meaning: Value(meaning),
      wordType: Value(wordType),
      verbGroup: verbGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(verbGroup),
      exampleJp: exampleJp == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleJp),
      exampleId: exampleId == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleId),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
      jlptLevel: Value(jlptLevel),
      isFavorite: Value(isFavorite),
    );
  }

  factory Vocabulary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vocabulary(
      id: serializer.fromJson<String>(json['id']),
      kanji: serializer.fromJson<String?>(json['kanji']),
      hiragana: serializer.fromJson<String>(json['hiragana']),
      romaji: serializer.fromJson<String?>(json['romaji']),
      meaning: serializer.fromJson<String>(json['meaning']),
      wordType: serializer.fromJson<String>(json['wordType']),
      verbGroup: serializer.fromJson<String?>(json['verbGroup']),
      exampleJp: serializer.fromJson<String?>(json['exampleJp']),
      exampleId: serializer.fromJson<String?>(json['exampleId']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
      jlptLevel: serializer.fromJson<String>(json['jlptLevel']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kanji': serializer.toJson<String?>(kanji),
      'hiragana': serializer.toJson<String>(hiragana),
      'romaji': serializer.toJson<String?>(romaji),
      'meaning': serializer.toJson<String>(meaning),
      'wordType': serializer.toJson<String>(wordType),
      'verbGroup': serializer.toJson<String?>(verbGroup),
      'exampleJp': serializer.toJson<String?>(exampleJp),
      'exampleId': serializer.toJson<String?>(exampleId),
      'audioPath': serializer.toJson<String?>(audioPath),
      'jlptLevel': serializer.toJson<String>(jlptLevel),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Vocabulary copyWith({
    String? id,
    Value<String?> kanji = const Value.absent(),
    String? hiragana,
    Value<String?> romaji = const Value.absent(),
    String? meaning,
    String? wordType,
    Value<String?> verbGroup = const Value.absent(),
    Value<String?> exampleJp = const Value.absent(),
    Value<String?> exampleId = const Value.absent(),
    Value<String?> audioPath = const Value.absent(),
    String? jlptLevel,
    bool? isFavorite,
  }) => Vocabulary(
    id: id ?? this.id,
    kanji: kanji.present ? kanji.value : this.kanji,
    hiragana: hiragana ?? this.hiragana,
    romaji: romaji.present ? romaji.value : this.romaji,
    meaning: meaning ?? this.meaning,
    wordType: wordType ?? this.wordType,
    verbGroup: verbGroup.present ? verbGroup.value : this.verbGroup,
    exampleJp: exampleJp.present ? exampleJp.value : this.exampleJp,
    exampleId: exampleId.present ? exampleId.value : this.exampleId,
    audioPath: audioPath.present ? audioPath.value : this.audioPath,
    jlptLevel: jlptLevel ?? this.jlptLevel,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  Vocabulary copyWithCompanion(VocabulariesCompanion data) {
    return Vocabulary(
      id: data.id.present ? data.id.value : this.id,
      kanji: data.kanji.present ? data.kanji.value : this.kanji,
      hiragana: data.hiragana.present ? data.hiragana.value : this.hiragana,
      romaji: data.romaji.present ? data.romaji.value : this.romaji,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      wordType: data.wordType.present ? data.wordType.value : this.wordType,
      verbGroup: data.verbGroup.present ? data.verbGroup.value : this.verbGroup,
      exampleJp: data.exampleJp.present ? data.exampleJp.value : this.exampleJp,
      exampleId: data.exampleId.present ? data.exampleId.value : this.exampleId,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      jlptLevel: data.jlptLevel.present ? data.jlptLevel.value : this.jlptLevel,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vocabulary(')
          ..write('id: $id, ')
          ..write('kanji: $kanji, ')
          ..write('hiragana: $hiragana, ')
          ..write('romaji: $romaji, ')
          ..write('meaning: $meaning, ')
          ..write('wordType: $wordType, ')
          ..write('verbGroup: $verbGroup, ')
          ..write('exampleJp: $exampleJp, ')
          ..write('exampleId: $exampleId, ')
          ..write('audioPath: $audioPath, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kanji,
    hiragana,
    romaji,
    meaning,
    wordType,
    verbGroup,
    exampleJp,
    exampleId,
    audioPath,
    jlptLevel,
    isFavorite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vocabulary &&
          other.id == this.id &&
          other.kanji == this.kanji &&
          other.hiragana == this.hiragana &&
          other.romaji == this.romaji &&
          other.meaning == this.meaning &&
          other.wordType == this.wordType &&
          other.verbGroup == this.verbGroup &&
          other.exampleJp == this.exampleJp &&
          other.exampleId == this.exampleId &&
          other.audioPath == this.audioPath &&
          other.jlptLevel == this.jlptLevel &&
          other.isFavorite == this.isFavorite);
}

class VocabulariesCompanion extends UpdateCompanion<Vocabulary> {
  final Value<String> id;
  final Value<String?> kanji;
  final Value<String> hiragana;
  final Value<String?> romaji;
  final Value<String> meaning;
  final Value<String> wordType;
  final Value<String?> verbGroup;
  final Value<String?> exampleJp;
  final Value<String?> exampleId;
  final Value<String?> audioPath;
  final Value<String> jlptLevel;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const VocabulariesCompanion({
    this.id = const Value.absent(),
    this.kanji = const Value.absent(),
    this.hiragana = const Value.absent(),
    this.romaji = const Value.absent(),
    this.meaning = const Value.absent(),
    this.wordType = const Value.absent(),
    this.verbGroup = const Value.absent(),
    this.exampleJp = const Value.absent(),
    this.exampleId = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.jlptLevel = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabulariesCompanion.insert({
    required String id,
    this.kanji = const Value.absent(),
    required String hiragana,
    this.romaji = const Value.absent(),
    required String meaning,
    required String wordType,
    this.verbGroup = const Value.absent(),
    this.exampleJp = const Value.absent(),
    this.exampleId = const Value.absent(),
    this.audioPath = const Value.absent(),
    required String jlptLevel,
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       hiragana = Value(hiragana),
       meaning = Value(meaning),
       wordType = Value(wordType),
       jlptLevel = Value(jlptLevel);
  static Insertable<Vocabulary> custom({
    Expression<String>? id,
    Expression<String>? kanji,
    Expression<String>? hiragana,
    Expression<String>? romaji,
    Expression<String>? meaning,
    Expression<String>? wordType,
    Expression<String>? verbGroup,
    Expression<String>? exampleJp,
    Expression<String>? exampleId,
    Expression<String>? audioPath,
    Expression<String>? jlptLevel,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanji != null) 'kanji': kanji,
      if (hiragana != null) 'hiragana': hiragana,
      if (romaji != null) 'romaji': romaji,
      if (meaning != null) 'meaning': meaning,
      if (wordType != null) 'word_type': wordType,
      if (verbGroup != null) 'verb_group': verbGroup,
      if (exampleJp != null) 'example_jp': exampleJp,
      if (exampleId != null) 'example_id': exampleId,
      if (audioPath != null) 'audio_path': audioPath,
      if (jlptLevel != null) 'jlpt_level': jlptLevel,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabulariesCompanion copyWith({
    Value<String>? id,
    Value<String?>? kanji,
    Value<String>? hiragana,
    Value<String?>? romaji,
    Value<String>? meaning,
    Value<String>? wordType,
    Value<String?>? verbGroup,
    Value<String?>? exampleJp,
    Value<String?>? exampleId,
    Value<String?>? audioPath,
    Value<String>? jlptLevel,
    Value<bool>? isFavorite,
    Value<int>? rowid,
  }) {
    return VocabulariesCompanion(
      id: id ?? this.id,
      kanji: kanji ?? this.kanji,
      hiragana: hiragana ?? this.hiragana,
      romaji: romaji ?? this.romaji,
      meaning: meaning ?? this.meaning,
      wordType: wordType ?? this.wordType,
      verbGroup: verbGroup ?? this.verbGroup,
      exampleJp: exampleJp ?? this.exampleJp,
      exampleId: exampleId ?? this.exampleId,
      audioPath: audioPath ?? this.audioPath,
      jlptLevel: jlptLevel ?? this.jlptLevel,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kanji.present) {
      map['kanji'] = Variable<String>(kanji.value);
    }
    if (hiragana.present) {
      map['hiragana'] = Variable<String>(hiragana.value);
    }
    if (romaji.present) {
      map['romaji'] = Variable<String>(romaji.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (wordType.present) {
      map['word_type'] = Variable<String>(wordType.value);
    }
    if (verbGroup.present) {
      map['verb_group'] = Variable<String>(verbGroup.value);
    }
    if (exampleJp.present) {
      map['example_jp'] = Variable<String>(exampleJp.value);
    }
    if (exampleId.present) {
      map['example_id'] = Variable<String>(exampleId.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (jlptLevel.present) {
      map['jlpt_level'] = Variable<String>(jlptLevel.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabulariesCompanion(')
          ..write('id: $id, ')
          ..write('kanji: $kanji, ')
          ..write('hiragana: $hiragana, ')
          ..write('romaji: $romaji, ')
          ..write('meaning: $meaning, ')
          ..write('wordType: $wordType, ')
          ..write('verbGroup: $verbGroup, ')
          ..write('exampleJp: $exampleJp, ')
          ..write('exampleId: $exampleId, ')
          ..write('audioPath: $audioPath, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningProgressesTable extends LearningProgresses
    with TableInfo<$LearningProgressesTable, LearningProgressesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningProgressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vocabularyIdMeta = const VerificationMeta(
    'vocabularyId',
  );
  @override
  late final GeneratedColumn<String> vocabularyId = GeneratedColumn<String>(
    'vocabulary_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vocabularies (id)',
    ),
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('new'),
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextReviewAtMeta = const VerificationMeta(
    'nextReviewAt',
  );
  @override
  late final GeneratedColumn<String> nextReviewAt = GeneratedColumn<String>(
    'next_review_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<String> lastReviewedAt = GeneratedColumn<String>(
    'last_reviewed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vocabularyId,
    direction,
    status,
    repetitions,
    correctCount,
    wrongCount,
    nextReviewAt,
    lastReviewedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_progresses';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningProgressesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vocabulary_id')) {
      context.handle(
        _vocabularyIdMeta,
        vocabularyId.isAcceptableOrUnknown(
          data['vocabulary_id']!,
          _vocabularyIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vocabularyIdMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
        _nextReviewAtMeta,
        nextReviewAt.isAcceptableOrUnknown(
          data['next_review_at']!,
          _nextReviewAtMeta,
        ),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningProgressesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningProgressesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vocabularyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vocabulary_id'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      repetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetitions'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      nextReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_review_at'],
      ),
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_reviewed_at'],
      ),
    );
  }

  @override
  $LearningProgressesTable createAlias(String alias) {
    return $LearningProgressesTable(attachedDatabase, alias);
  }
}

class LearningProgressesData extends DataClass
    implements Insertable<LearningProgressesData> {
  final int id;
  final String vocabularyId;
  final String direction;
  final String status;
  final int repetitions;
  final int correctCount;
  final int wrongCount;
  final String? nextReviewAt;
  final String? lastReviewedAt;
  const LearningProgressesData({
    required this.id,
    required this.vocabularyId,
    required this.direction,
    required this.status,
    required this.repetitions,
    required this.correctCount,
    required this.wrongCount,
    this.nextReviewAt,
    this.lastReviewedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vocabulary_id'] = Variable<String>(vocabularyId);
    map['direction'] = Variable<String>(direction);
    map['status'] = Variable<String>(status);
    map['repetitions'] = Variable<int>(repetitions);
    map['correct_count'] = Variable<int>(correctCount);
    map['wrong_count'] = Variable<int>(wrongCount);
    if (!nullToAbsent || nextReviewAt != null) {
      map['next_review_at'] = Variable<String>(nextReviewAt);
    }
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<String>(lastReviewedAt);
    }
    return map;
  }

  LearningProgressesCompanion toCompanion(bool nullToAbsent) {
    return LearningProgressesCompanion(
      id: Value(id),
      vocabularyId: Value(vocabularyId),
      direction: Value(direction),
      status: Value(status),
      repetitions: Value(repetitions),
      correctCount: Value(correctCount),
      wrongCount: Value(wrongCount),
      nextReviewAt: nextReviewAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReviewAt),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
    );
  }

  factory LearningProgressesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningProgressesData(
      id: serializer.fromJson<int>(json['id']),
      vocabularyId: serializer.fromJson<String>(json['vocabularyId']),
      direction: serializer.fromJson<String>(json['direction']),
      status: serializer.fromJson<String>(json['status']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      nextReviewAt: serializer.fromJson<String?>(json['nextReviewAt']),
      lastReviewedAt: serializer.fromJson<String?>(json['lastReviewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vocabularyId': serializer.toJson<String>(vocabularyId),
      'direction': serializer.toJson<String>(direction),
      'status': serializer.toJson<String>(status),
      'repetitions': serializer.toJson<int>(repetitions),
      'correctCount': serializer.toJson<int>(correctCount),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'nextReviewAt': serializer.toJson<String?>(nextReviewAt),
      'lastReviewedAt': serializer.toJson<String?>(lastReviewedAt),
    };
  }

  LearningProgressesData copyWith({
    int? id,
    String? vocabularyId,
    String? direction,
    String? status,
    int? repetitions,
    int? correctCount,
    int? wrongCount,
    Value<String?> nextReviewAt = const Value.absent(),
    Value<String?> lastReviewedAt = const Value.absent(),
  }) => LearningProgressesData(
    id: id ?? this.id,
    vocabularyId: vocabularyId ?? this.vocabularyId,
    direction: direction ?? this.direction,
    status: status ?? this.status,
    repetitions: repetitions ?? this.repetitions,
    correctCount: correctCount ?? this.correctCount,
    wrongCount: wrongCount ?? this.wrongCount,
    nextReviewAt: nextReviewAt.present ? nextReviewAt.value : this.nextReviewAt,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
  );
  LearningProgressesData copyWithCompanion(LearningProgressesCompanion data) {
    return LearningProgressesData(
      id: data.id.present ? data.id.value : this.id,
      vocabularyId: data.vocabularyId.present
          ? data.vocabularyId.value
          : this.vocabularyId,
      direction: data.direction.present ? data.direction.value : this.direction,
      status: data.status.present ? data.status.value : this.status,
      repetitions: data.repetitions.present
          ? data.repetitions.value
          : this.repetitions,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningProgressesData(')
          ..write('id: $id, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('direction: $direction, ')
          ..write('status: $status, ')
          ..write('repetitions: $repetitions, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('lastReviewedAt: $lastReviewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vocabularyId,
    direction,
    status,
    repetitions,
    correctCount,
    wrongCount,
    nextReviewAt,
    lastReviewedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningProgressesData &&
          other.id == this.id &&
          other.vocabularyId == this.vocabularyId &&
          other.direction == this.direction &&
          other.status == this.status &&
          other.repetitions == this.repetitions &&
          other.correctCount == this.correctCount &&
          other.wrongCount == this.wrongCount &&
          other.nextReviewAt == this.nextReviewAt &&
          other.lastReviewedAt == this.lastReviewedAt);
}

class LearningProgressesCompanion
    extends UpdateCompanion<LearningProgressesData> {
  final Value<int> id;
  final Value<String> vocabularyId;
  final Value<String> direction;
  final Value<String> status;
  final Value<int> repetitions;
  final Value<int> correctCount;
  final Value<int> wrongCount;
  final Value<String?> nextReviewAt;
  final Value<String?> lastReviewedAt;
  const LearningProgressesCompanion({
    this.id = const Value.absent(),
    this.vocabularyId = const Value.absent(),
    this.direction = const Value.absent(),
    this.status = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
  });
  LearningProgressesCompanion.insert({
    this.id = const Value.absent(),
    required String vocabularyId,
    required String direction,
    this.status = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
  }) : vocabularyId = Value(vocabularyId),
       direction = Value(direction);
  static Insertable<LearningProgressesData> custom({
    Expression<int>? id,
    Expression<String>? vocabularyId,
    Expression<String>? direction,
    Expression<String>? status,
    Expression<int>? repetitions,
    Expression<int>? correctCount,
    Expression<int>? wrongCount,
    Expression<String>? nextReviewAt,
    Expression<String>? lastReviewedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vocabularyId != null) 'vocabulary_id': vocabularyId,
      if (direction != null) 'direction': direction,
      if (status != null) 'status': status,
      if (repetitions != null) 'repetitions': repetitions,
      if (correctCount != null) 'correct_count': correctCount,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
    });
  }

  LearningProgressesCompanion copyWith({
    Value<int>? id,
    Value<String>? vocabularyId,
    Value<String>? direction,
    Value<String>? status,
    Value<int>? repetitions,
    Value<int>? correctCount,
    Value<int>? wrongCount,
    Value<String?>? nextReviewAt,
    Value<String?>? lastReviewedAt,
  }) {
    return LearningProgressesCompanion(
      id: id ?? this.id,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      direction: direction ?? this.direction,
      status: status ?? this.status,
      repetitions: repetitions ?? this.repetitions,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vocabularyId.present) {
      map['vocabulary_id'] = Variable<String>(vocabularyId.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<String>(nextReviewAt.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<String>(lastReviewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningProgressesCompanion(')
          ..write('id: $id, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('direction: $direction, ')
          ..write('status: $status, ')
          ..write('repetitions: $repetitions, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('lastReviewedAt: $lastReviewedAt')
          ..write(')'))
        .toString();
  }
}

class $QuizAttemptsTable extends QuizAttempts
    with TableInfo<$QuizAttemptsTable, QuizAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vocabularyIdMeta = const VerificationMeta(
    'vocabularyId',
  );
  @override
  late final GeneratedColumn<String> vocabularyId = GeneratedColumn<String>(
    'vocabulary_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vocabularies (id)',
    ),
  );
  static const VerificationMeta _questionTypeMeta = const VerificationMeta(
    'questionType',
  );
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
    'question_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userAnswerMeta = const VerificationMeta(
    'userAnswer',
  );
  @override
  late final GeneratedColumn<String> userAnswer = GeneratedColumn<String>(
    'user_answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
  );
  static const VerificationMeta _attemptedAtMeta = const VerificationMeta(
    'attemptedAt',
  );
  @override
  late final GeneratedColumn<String> attemptedAt = GeneratedColumn<String>(
    'attempted_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vocabularyId,
    questionType,
    userAnswer,
    isCorrect,
    attemptedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuizAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vocabulary_id')) {
      context.handle(
        _vocabularyIdMeta,
        vocabularyId.isAcceptableOrUnknown(
          data['vocabulary_id']!,
          _vocabularyIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vocabularyIdMeta);
    }
    if (data.containsKey('question_type')) {
      context.handle(
        _questionTypeMeta,
        questionType.isAcceptableOrUnknown(
          data['question_type']!,
          _questionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionTypeMeta);
    }
    if (data.containsKey('user_answer')) {
      context.handle(
        _userAnswerMeta,
        userAnswer.isAcceptableOrUnknown(data['user_answer']!, _userAnswerMeta),
      );
    } else if (isInserting) {
      context.missing(_userAnswerMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('attempted_at')) {
      context.handle(
        _attemptedAtMeta,
        attemptedAt.isAcceptableOrUnknown(
          data['attempted_at']!,
          _attemptedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attemptedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizAttempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vocabularyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vocabulary_id'],
      )!,
      questionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_type'],
      )!,
      userAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_answer'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
      attemptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attempted_at'],
      )!,
    );
  }

  @override
  $QuizAttemptsTable createAlias(String alias) {
    return $QuizAttemptsTable(attachedDatabase, alias);
  }
}

class QuizAttempt extends DataClass implements Insertable<QuizAttempt> {
  final int id;
  final String vocabularyId;
  final String questionType;
  final String userAnswer;
  final bool isCorrect;
  final String attemptedAt;
  const QuizAttempt({
    required this.id,
    required this.vocabularyId,
    required this.questionType,
    required this.userAnswer,
    required this.isCorrect,
    required this.attemptedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vocabulary_id'] = Variable<String>(vocabularyId);
    map['question_type'] = Variable<String>(questionType);
    map['user_answer'] = Variable<String>(userAnswer);
    map['is_correct'] = Variable<bool>(isCorrect);
    map['attempted_at'] = Variable<String>(attemptedAt);
    return map;
  }

  QuizAttemptsCompanion toCompanion(bool nullToAbsent) {
    return QuizAttemptsCompanion(
      id: Value(id),
      vocabularyId: Value(vocabularyId),
      questionType: Value(questionType),
      userAnswer: Value(userAnswer),
      isCorrect: Value(isCorrect),
      attemptedAt: Value(attemptedAt),
    );
  }

  factory QuizAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizAttempt(
      id: serializer.fromJson<int>(json['id']),
      vocabularyId: serializer.fromJson<String>(json['vocabularyId']),
      questionType: serializer.fromJson<String>(json['questionType']),
      userAnswer: serializer.fromJson<String>(json['userAnswer']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      attemptedAt: serializer.fromJson<String>(json['attemptedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vocabularyId': serializer.toJson<String>(vocabularyId),
      'questionType': serializer.toJson<String>(questionType),
      'userAnswer': serializer.toJson<String>(userAnswer),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'attemptedAt': serializer.toJson<String>(attemptedAt),
    };
  }

  QuizAttempt copyWith({
    int? id,
    String? vocabularyId,
    String? questionType,
    String? userAnswer,
    bool? isCorrect,
    String? attemptedAt,
  }) => QuizAttempt(
    id: id ?? this.id,
    vocabularyId: vocabularyId ?? this.vocabularyId,
    questionType: questionType ?? this.questionType,
    userAnswer: userAnswer ?? this.userAnswer,
    isCorrect: isCorrect ?? this.isCorrect,
    attemptedAt: attemptedAt ?? this.attemptedAt,
  );
  QuizAttempt copyWithCompanion(QuizAttemptsCompanion data) {
    return QuizAttempt(
      id: data.id.present ? data.id.value : this.id,
      vocabularyId: data.vocabularyId.present
          ? data.vocabularyId.value
          : this.vocabularyId,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      userAnswer: data.userAnswer.present
          ? data.userAnswer.value
          : this.userAnswer,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      attemptedAt: data.attemptedAt.present
          ? data.attemptedAt.value
          : this.attemptedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizAttempt(')
          ..write('id: $id, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('questionType: $questionType, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('attemptedAt: $attemptedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vocabularyId,
    questionType,
    userAnswer,
    isCorrect,
    attemptedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizAttempt &&
          other.id == this.id &&
          other.vocabularyId == this.vocabularyId &&
          other.questionType == this.questionType &&
          other.userAnswer == this.userAnswer &&
          other.isCorrect == this.isCorrect &&
          other.attemptedAt == this.attemptedAt);
}

class QuizAttemptsCompanion extends UpdateCompanion<QuizAttempt> {
  final Value<int> id;
  final Value<String> vocabularyId;
  final Value<String> questionType;
  final Value<String> userAnswer;
  final Value<bool> isCorrect;
  final Value<String> attemptedAt;
  const QuizAttemptsCompanion({
    this.id = const Value.absent(),
    this.vocabularyId = const Value.absent(),
    this.questionType = const Value.absent(),
    this.userAnswer = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.attemptedAt = const Value.absent(),
  });
  QuizAttemptsCompanion.insert({
    this.id = const Value.absent(),
    required String vocabularyId,
    required String questionType,
    required String userAnswer,
    required bool isCorrect,
    required String attemptedAt,
  }) : vocabularyId = Value(vocabularyId),
       questionType = Value(questionType),
       userAnswer = Value(userAnswer),
       isCorrect = Value(isCorrect),
       attemptedAt = Value(attemptedAt);
  static Insertable<QuizAttempt> custom({
    Expression<int>? id,
    Expression<String>? vocabularyId,
    Expression<String>? questionType,
    Expression<String>? userAnswer,
    Expression<bool>? isCorrect,
    Expression<String>? attemptedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vocabularyId != null) 'vocabulary_id': vocabularyId,
      if (questionType != null) 'question_type': questionType,
      if (userAnswer != null) 'user_answer': userAnswer,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (attemptedAt != null) 'attempted_at': attemptedAt,
    });
  }

  QuizAttemptsCompanion copyWith({
    Value<int>? id,
    Value<String>? vocabularyId,
    Value<String>? questionType,
    Value<String>? userAnswer,
    Value<bool>? isCorrect,
    Value<String>? attemptedAt,
  }) {
    return QuizAttemptsCompanion(
      id: id ?? this.id,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      questionType: questionType ?? this.questionType,
      userAnswer: userAnswer ?? this.userAnswer,
      isCorrect: isCorrect ?? this.isCorrect,
      attemptedAt: attemptedAt ?? this.attemptedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vocabularyId.present) {
      map['vocabulary_id'] = Variable<String>(vocabularyId.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (userAnswer.present) {
      map['user_answer'] = Variable<String>(userAnswer.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (attemptedAt.present) {
      map['attempted_at'] = Variable<String>(attemptedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('questionType: $questionType, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('attemptedAt: $attemptedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyActivitiesTable extends DailyActivities
    with TableInfo<$DailyActivitiesTable, DailyActivity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordsStudiedMeta = const VerificationMeta(
    'wordsStudied',
  );
  @override
  late final GeneratedColumn<int> wordsStudied = GeneratedColumn<int>(
    'words_studied',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wrongAnswersMeta = const VerificationMeta(
    'wrongAnswers',
  );
  @override
  late final GeneratedColumn<int> wrongAnswers = GeneratedColumn<int>(
    'wrong_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _studyDurationSecondsMeta =
      const VerificationMeta('studyDurationSeconds');
  @override
  late final GeneratedColumn<int> studyDurationSeconds = GeneratedColumn<int>(
    'study_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    wordsStudied,
    correctAnswers,
    wrongAnswers,
    studyDurationSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyActivity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('words_studied')) {
      context.handle(
        _wordsStudiedMeta,
        wordsStudied.isAcceptableOrUnknown(
          data['words_studied']!,
          _wordsStudiedMeta,
        ),
      );
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    }
    if (data.containsKey('wrong_answers')) {
      context.handle(
        _wrongAnswersMeta,
        wrongAnswers.isAcceptableOrUnknown(
          data['wrong_answers']!,
          _wrongAnswersMeta,
        ),
      );
    }
    if (data.containsKey('study_duration_seconds')) {
      context.handle(
        _studyDurationSecondsMeta,
        studyDurationSeconds.isAcceptableOrUnknown(
          data['study_duration_seconds']!,
          _studyDurationSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DailyActivity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyActivity(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      wordsStudied: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}words_studied'],
      )!,
      correctAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_answers'],
      )!,
      wrongAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_answers'],
      )!,
      studyDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}study_duration_seconds'],
      )!,
    );
  }

  @override
  $DailyActivitiesTable createAlias(String alias) {
    return $DailyActivitiesTable(attachedDatabase, alias);
  }
}

class DailyActivity extends DataClass implements Insertable<DailyActivity> {
  final String date;
  final int wordsStudied;
  final int correctAnswers;
  final int wrongAnswers;
  final int studyDurationSeconds;
  const DailyActivity({
    required this.date,
    required this.wordsStudied,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.studyDurationSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['words_studied'] = Variable<int>(wordsStudied);
    map['correct_answers'] = Variable<int>(correctAnswers);
    map['wrong_answers'] = Variable<int>(wrongAnswers);
    map['study_duration_seconds'] = Variable<int>(studyDurationSeconds);
    return map;
  }

  DailyActivitiesCompanion toCompanion(bool nullToAbsent) {
    return DailyActivitiesCompanion(
      date: Value(date),
      wordsStudied: Value(wordsStudied),
      correctAnswers: Value(correctAnswers),
      wrongAnswers: Value(wrongAnswers),
      studyDurationSeconds: Value(studyDurationSeconds),
    );
  }

  factory DailyActivity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyActivity(
      date: serializer.fromJson<String>(json['date']),
      wordsStudied: serializer.fromJson<int>(json['wordsStudied']),
      correctAnswers: serializer.fromJson<int>(json['correctAnswers']),
      wrongAnswers: serializer.fromJson<int>(json['wrongAnswers']),
      studyDurationSeconds: serializer.fromJson<int>(
        json['studyDurationSeconds'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'wordsStudied': serializer.toJson<int>(wordsStudied),
      'correctAnswers': serializer.toJson<int>(correctAnswers),
      'wrongAnswers': serializer.toJson<int>(wrongAnswers),
      'studyDurationSeconds': serializer.toJson<int>(studyDurationSeconds),
    };
  }

  DailyActivity copyWith({
    String? date,
    int? wordsStudied,
    int? correctAnswers,
    int? wrongAnswers,
    int? studyDurationSeconds,
  }) => DailyActivity(
    date: date ?? this.date,
    wordsStudied: wordsStudied ?? this.wordsStudied,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    wrongAnswers: wrongAnswers ?? this.wrongAnswers,
    studyDurationSeconds: studyDurationSeconds ?? this.studyDurationSeconds,
  );
  DailyActivity copyWithCompanion(DailyActivitiesCompanion data) {
    return DailyActivity(
      date: data.date.present ? data.date.value : this.date,
      wordsStudied: data.wordsStudied.present
          ? data.wordsStudied.value
          : this.wordsStudied,
      correctAnswers: data.correctAnswers.present
          ? data.correctAnswers.value
          : this.correctAnswers,
      wrongAnswers: data.wrongAnswers.present
          ? data.wrongAnswers.value
          : this.wrongAnswers,
      studyDurationSeconds: data.studyDurationSeconds.present
          ? data.studyDurationSeconds.value
          : this.studyDurationSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyActivity(')
          ..write('date: $date, ')
          ..write('wordsStudied: $wordsStudied, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('wrongAnswers: $wrongAnswers, ')
          ..write('studyDurationSeconds: $studyDurationSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    date,
    wordsStudied,
    correctAnswers,
    wrongAnswers,
    studyDurationSeconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyActivity &&
          other.date == this.date &&
          other.wordsStudied == this.wordsStudied &&
          other.correctAnswers == this.correctAnswers &&
          other.wrongAnswers == this.wrongAnswers &&
          other.studyDurationSeconds == this.studyDurationSeconds);
}

class DailyActivitiesCompanion extends UpdateCompanion<DailyActivity> {
  final Value<String> date;
  final Value<int> wordsStudied;
  final Value<int> correctAnswers;
  final Value<int> wrongAnswers;
  final Value<int> studyDurationSeconds;
  final Value<int> rowid;
  const DailyActivitiesCompanion({
    this.date = const Value.absent(),
    this.wordsStudied = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.wrongAnswers = const Value.absent(),
    this.studyDurationSeconds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyActivitiesCompanion.insert({
    required String date,
    this.wordsStudied = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.wrongAnswers = const Value.absent(),
    this.studyDurationSeconds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DailyActivity> custom({
    Expression<String>? date,
    Expression<int>? wordsStudied,
    Expression<int>? correctAnswers,
    Expression<int>? wrongAnswers,
    Expression<int>? studyDurationSeconds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (wordsStudied != null) 'words_studied': wordsStudied,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (wrongAnswers != null) 'wrong_answers': wrongAnswers,
      if (studyDurationSeconds != null)
        'study_duration_seconds': studyDurationSeconds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyActivitiesCompanion copyWith({
    Value<String>? date,
    Value<int>? wordsStudied,
    Value<int>? correctAnswers,
    Value<int>? wrongAnswers,
    Value<int>? studyDurationSeconds,
    Value<int>? rowid,
  }) {
    return DailyActivitiesCompanion(
      date: date ?? this.date,
      wordsStudied: wordsStudied ?? this.wordsStudied,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      studyDurationSeconds: studyDurationSeconds ?? this.studyDurationSeconds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (wordsStudied.present) {
      map['words_studied'] = Variable<int>(wordsStudied.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (wrongAnswers.present) {
      map['wrong_answers'] = Variable<int>(wrongAnswers.value);
    }
    if (studyDurationSeconds.present) {
      map['study_duration_seconds'] = Variable<int>(studyDurationSeconds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyActivitiesCompanion(')
          ..write('date: $date, ')
          ..write('wordsStudied: $wordsStudied, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('wrongAnswers: $wrongAnswers, ')
          ..write('studyDurationSeconds: $studyDurationSeconds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VocabulariesTable vocabularies = $VocabulariesTable(this);
  late final $LearningProgressesTable learningProgresses =
      $LearningProgressesTable(this);
  late final $QuizAttemptsTable quizAttempts = $QuizAttemptsTable(this);
  late final $DailyActivitiesTable dailyActivities = $DailyActivitiesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    vocabularies,
    learningProgresses,
    quizAttempts,
    dailyActivities,
  ];
}

typedef $$VocabulariesTableCreateCompanionBuilder =
    VocabulariesCompanion Function({
      required String id,
      Value<String?> kanji,
      required String hiragana,
      Value<String?> romaji,
      required String meaning,
      required String wordType,
      Value<String?> verbGroup,
      Value<String?> exampleJp,
      Value<String?> exampleId,
      Value<String?> audioPath,
      required String jlptLevel,
      Value<bool> isFavorite,
      Value<int> rowid,
    });
typedef $$VocabulariesTableUpdateCompanionBuilder =
    VocabulariesCompanion Function({
      Value<String> id,
      Value<String?> kanji,
      Value<String> hiragana,
      Value<String?> romaji,
      Value<String> meaning,
      Value<String> wordType,
      Value<String?> verbGroup,
      Value<String?> exampleJp,
      Value<String?> exampleId,
      Value<String?> audioPath,
      Value<String> jlptLevel,
      Value<bool> isFavorite,
      Value<int> rowid,
    });

final class $$VocabulariesTableReferences
    extends BaseReferences<_$AppDatabase, $VocabulariesTable, Vocabulary> {
  $$VocabulariesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $LearningProgressesTable,
    List<LearningProgressesData>
  >
  _learningProgressesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.learningProgresses,
        aliasName: 'vocabularies__id__learning_progresses__vocabulary_id',
      );

  $$LearningProgressesTableProcessedTableManager get learningProgressesRefs {
    final manager = $$LearningProgressesTableTableManager(
      $_db,
      $_db.learningProgresses,
    ).filter((f) => f.vocabularyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learningProgressesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuizAttemptsTable, List<QuizAttempt>>
  _quizAttemptsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.quizAttempts,
    aliasName: 'vocabularies__id__quiz_attempts__vocabulary_id',
  );

  $$QuizAttemptsTableProcessedTableManager get quizAttemptsRefs {
    final manager = $$QuizAttemptsTableTableManager(
      $_db,
      $_db.quizAttempts,
    ).filter((f) => f.vocabularyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quizAttemptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VocabulariesTableFilterComposer
    extends Composer<_$AppDatabase, $VocabulariesTable> {
  $$VocabulariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hiragana => $composableBuilder(
    column: $table.hiragana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get romaji => $composableBuilder(
    column: $table.romaji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordType => $composableBuilder(
    column: $table.wordType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verbGroup => $composableBuilder(
    column: $table.verbGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleJp => $composableBuilder(
    column: $table.exampleJp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleId => $composableBuilder(
    column: $table.exampleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jlptLevel => $composableBuilder(
    column: $table.jlptLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> learningProgressesRefs(
    Expression<bool> Function($$LearningProgressesTableFilterComposer f) f,
  ) {
    final $$LearningProgressesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningProgresses,
      getReferencedColumn: (t) => t.vocabularyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningProgressesTableFilterComposer(
            $db: $db,
            $table: $db.learningProgresses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> quizAttemptsRefs(
    Expression<bool> Function($$QuizAttemptsTableFilterComposer f) f,
  ) {
    final $$QuizAttemptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizAttempts,
      getReferencedColumn: (t) => t.vocabularyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizAttemptsTableFilterComposer(
            $db: $db,
            $table: $db.quizAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VocabulariesTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabulariesTable> {
  $$VocabulariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hiragana => $composableBuilder(
    column: $table.hiragana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get romaji => $composableBuilder(
    column: $table.romaji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordType => $composableBuilder(
    column: $table.wordType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verbGroup => $composableBuilder(
    column: $table.verbGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleJp => $composableBuilder(
    column: $table.exampleJp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleId => $composableBuilder(
    column: $table.exampleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jlptLevel => $composableBuilder(
    column: $table.jlptLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VocabulariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabulariesTable> {
  $$VocabulariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kanji =>
      $composableBuilder(column: $table.kanji, builder: (column) => column);

  GeneratedColumn<String> get hiragana =>
      $composableBuilder(column: $table.hiragana, builder: (column) => column);

  GeneratedColumn<String> get romaji =>
      $composableBuilder(column: $table.romaji, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get wordType =>
      $composableBuilder(column: $table.wordType, builder: (column) => column);

  GeneratedColumn<String> get verbGroup =>
      $composableBuilder(column: $table.verbGroup, builder: (column) => column);

  GeneratedColumn<String> get exampleJp =>
      $composableBuilder(column: $table.exampleJp, builder: (column) => column);

  GeneratedColumn<String> get exampleId =>
      $composableBuilder(column: $table.exampleId, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<String> get jlptLevel =>
      $composableBuilder(column: $table.jlptLevel, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  Expression<T> learningProgressesRefs<T extends Object>(
    Expression<T> Function($$LearningProgressesTableAnnotationComposer a) f,
  ) {
    final $$LearningProgressesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.learningProgresses,
          getReferencedColumn: (t) => t.vocabularyId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningProgressesTableAnnotationComposer(
                $db: $db,
                $table: $db.learningProgresses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> quizAttemptsRefs<T extends Object>(
    Expression<T> Function($$QuizAttemptsTableAnnotationComposer a) f,
  ) {
    final $$QuizAttemptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizAttempts,
      getReferencedColumn: (t) => t.vocabularyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizAttemptsTableAnnotationComposer(
            $db: $db,
            $table: $db.quizAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VocabulariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabulariesTable,
          Vocabulary,
          $$VocabulariesTableFilterComposer,
          $$VocabulariesTableOrderingComposer,
          $$VocabulariesTableAnnotationComposer,
          $$VocabulariesTableCreateCompanionBuilder,
          $$VocabulariesTableUpdateCompanionBuilder,
          (Vocabulary, $$VocabulariesTableReferences),
          Vocabulary,
          PrefetchHooks Function({
            bool learningProgressesRefs,
            bool quizAttemptsRefs,
          })
        > {
  $$VocabulariesTableTableManager(_$AppDatabase db, $VocabulariesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabulariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabulariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabulariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> kanji = const Value.absent(),
                Value<String> hiragana = const Value.absent(),
                Value<String?> romaji = const Value.absent(),
                Value<String> meaning = const Value.absent(),
                Value<String> wordType = const Value.absent(),
                Value<String?> verbGroup = const Value.absent(),
                Value<String?> exampleJp = const Value.absent(),
                Value<String?> exampleId = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                Value<String> jlptLevel = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabulariesCompanion(
                id: id,
                kanji: kanji,
                hiragana: hiragana,
                romaji: romaji,
                meaning: meaning,
                wordType: wordType,
                verbGroup: verbGroup,
                exampleJp: exampleJp,
                exampleId: exampleId,
                audioPath: audioPath,
                jlptLevel: jlptLevel,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> kanji = const Value.absent(),
                required String hiragana,
                Value<String?> romaji = const Value.absent(),
                required String meaning,
                required String wordType,
                Value<String?> verbGroup = const Value.absent(),
                Value<String?> exampleJp = const Value.absent(),
                Value<String?> exampleId = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                required String jlptLevel,
                Value<bool> isFavorite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabulariesCompanion.insert(
                id: id,
                kanji: kanji,
                hiragana: hiragana,
                romaji: romaji,
                meaning: meaning,
                wordType: wordType,
                verbGroup: verbGroup,
                exampleJp: exampleJp,
                exampleId: exampleId,
                audioPath: audioPath,
                jlptLevel: jlptLevel,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VocabulariesTable, Vocabulary>(table),
                  $$VocabulariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({learningProgressesRefs = false, quizAttemptsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (learningProgressesRefs) db.learningProgresses,
                    if (quizAttemptsRefs) db.quizAttempts,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (learningProgressesRefs)
                        await $_getPrefetchedDataByColumns<
                          Vocabulary,
                          $VocabulariesTable,
                          LearningProgressesData,
                          $LearningProgressesTable
                        >(
                          currentTable: table,
                          referencedTable: $$VocabulariesTableReferences
                              ._learningProgressesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VocabulariesTableReferences(
                                db,
                                table,
                                p0,
                              ).learningProgressesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'vocabulary_id',
                          typedResults: items,
                        ),
                      if (quizAttemptsRefs)
                        await $_getPrefetchedDataByColumns<
                          Vocabulary,
                          $VocabulariesTable,
                          QuizAttempt,
                          $QuizAttemptsTable
                        >(
                          currentTable: table,
                          referencedTable: $$VocabulariesTableReferences
                              ._quizAttemptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VocabulariesTableReferences(
                                db,
                                table,
                                p0,
                              ).quizAttemptsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'vocabulary_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VocabulariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabulariesTable,
      Vocabulary,
      $$VocabulariesTableFilterComposer,
      $$VocabulariesTableOrderingComposer,
      $$VocabulariesTableAnnotationComposer,
      $$VocabulariesTableCreateCompanionBuilder,
      $$VocabulariesTableUpdateCompanionBuilder,
      (Vocabulary, $$VocabulariesTableReferences),
      Vocabulary,
      PrefetchHooks Function({
        bool learningProgressesRefs,
        bool quizAttemptsRefs,
      })
    >;
typedef $$LearningProgressesTableCreateCompanionBuilder =
    LearningProgressesCompanion Function({
      Value<int> id,
      required String vocabularyId,
      required String direction,
      Value<String> status,
      Value<int> repetitions,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<String?> nextReviewAt,
      Value<String?> lastReviewedAt,
    });
typedef $$LearningProgressesTableUpdateCompanionBuilder =
    LearningProgressesCompanion Function({
      Value<int> id,
      Value<String> vocabularyId,
      Value<String> direction,
      Value<String> status,
      Value<int> repetitions,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<String?> nextReviewAt,
      Value<String?> lastReviewedAt,
    });

final class $$LearningProgressesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LearningProgressesTable,
          LearningProgressesData
        > {
  $$LearningProgressesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VocabulariesTable _vocabularyIdTable(_$AppDatabase db) => db
      .vocabularies
      .createAlias('learning_progresses__vocabulary_id__vocabularies__id');

  $$VocabulariesTableProcessedTableManager get vocabularyId {
    final $_column = $_itemColumn<String>('vocabulary_id')!;

    final manager = $$VocabulariesTableTableManager(
      $_db,
      $_db.vocabularies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vocabularyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LearningProgressesTableFilterComposer
    extends Composer<_$AppDatabase, $LearningProgressesTable> {
  $$LearningProgressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VocabulariesTableFilterComposer get vocabularyId {
    final $$VocabulariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabulariesTableFilterComposer(
            $db: $db,
            $table: $db.vocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningProgressesTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningProgressesTable> {
  $$LearningProgressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VocabulariesTableOrderingComposer get vocabularyId {
    final $$VocabulariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabulariesTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningProgressesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningProgressesTable> {
  $$LearningProgressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );

  $$VocabulariesTableAnnotationComposer get vocabularyId {
    final $$VocabulariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabulariesTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningProgressesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningProgressesTable,
          LearningProgressesData,
          $$LearningProgressesTableFilterComposer,
          $$LearningProgressesTableOrderingComposer,
          $$LearningProgressesTableAnnotationComposer,
          $$LearningProgressesTableCreateCompanionBuilder,
          $$LearningProgressesTableUpdateCompanionBuilder,
          (LearningProgressesData, $$LearningProgressesTableReferences),
          LearningProgressesData,
          PrefetchHooks Function({bool vocabularyId})
        > {
  $$LearningProgressesTableTableManager(
    _$AppDatabase db,
    $LearningProgressesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningProgressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningProgressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningProgressesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> vocabularyId = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<String?> nextReviewAt = const Value.absent(),
                Value<String?> lastReviewedAt = const Value.absent(),
              }) => LearningProgressesCompanion(
                id: id,
                vocabularyId: vocabularyId,
                direction: direction,
                status: status,
                repetitions: repetitions,
                correctCount: correctCount,
                wrongCount: wrongCount,
                nextReviewAt: nextReviewAt,
                lastReviewedAt: lastReviewedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String vocabularyId,
                required String direction,
                Value<String> status = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<String?> nextReviewAt = const Value.absent(),
                Value<String?> lastReviewedAt = const Value.absent(),
              }) => LearningProgressesCompanion.insert(
                id: id,
                vocabularyId: vocabularyId,
                direction: direction,
                status: status,
                repetitions: repetitions,
                correctCount: correctCount,
                wrongCount: wrongCount,
                nextReviewAt: nextReviewAt,
                lastReviewedAt: lastReviewedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LearningProgressesTable, LearningProgressesData>(
                    table,
                  ),
                  $$LearningProgressesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vocabularyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vocabularyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vocabularyId,
                                referencedTable:
                                    $$LearningProgressesTableReferences
                                        ._vocabularyIdTable(db),
                                referencedColumn:
                                    $$LearningProgressesTableReferences
                                        ._vocabularyIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LearningProgressesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningProgressesTable,
      LearningProgressesData,
      $$LearningProgressesTableFilterComposer,
      $$LearningProgressesTableOrderingComposer,
      $$LearningProgressesTableAnnotationComposer,
      $$LearningProgressesTableCreateCompanionBuilder,
      $$LearningProgressesTableUpdateCompanionBuilder,
      (LearningProgressesData, $$LearningProgressesTableReferences),
      LearningProgressesData,
      PrefetchHooks Function({bool vocabularyId})
    >;
typedef $$QuizAttemptsTableCreateCompanionBuilder =
    QuizAttemptsCompanion Function({
      Value<int> id,
      required String vocabularyId,
      required String questionType,
      required String userAnswer,
      required bool isCorrect,
      required String attemptedAt,
    });
typedef $$QuizAttemptsTableUpdateCompanionBuilder =
    QuizAttemptsCompanion Function({
      Value<int> id,
      Value<String> vocabularyId,
      Value<String> questionType,
      Value<String> userAnswer,
      Value<bool> isCorrect,
      Value<String> attemptedAt,
    });

final class $$QuizAttemptsTableReferences
    extends BaseReferences<_$AppDatabase, $QuizAttemptsTable, QuizAttempt> {
  $$QuizAttemptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VocabulariesTable _vocabularyIdTable(_$AppDatabase db) => db
      .vocabularies
      .createAlias('quiz_attempts__vocabulary_id__vocabularies__id');

  $$VocabulariesTableProcessedTableManager get vocabularyId {
    final $_column = $_itemColumn<String>('vocabulary_id')!;

    final manager = $$VocabulariesTableTableManager(
      $_db,
      $_db.vocabularies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vocabularyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuizAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $QuizAttemptsTable> {
  $$QuizAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userAnswer => $composableBuilder(
    column: $table.userAnswer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VocabulariesTableFilterComposer get vocabularyId {
    final $$VocabulariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabulariesTableFilterComposer(
            $db: $db,
            $table: $db.vocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizAttemptsTable> {
  $$QuizAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userAnswer => $composableBuilder(
    column: $table.userAnswer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VocabulariesTableOrderingComposer get vocabularyId {
    final $$VocabulariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabulariesTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizAttemptsTable> {
  $$QuizAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userAnswer => $composableBuilder(
    column: $table.userAnswer,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<String> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => column,
  );

  $$VocabulariesTableAnnotationComposer get vocabularyId {
    final $$VocabulariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabulariesTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabularies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuizAttemptsTable,
          QuizAttempt,
          $$QuizAttemptsTableFilterComposer,
          $$QuizAttemptsTableOrderingComposer,
          $$QuizAttemptsTableAnnotationComposer,
          $$QuizAttemptsTableCreateCompanionBuilder,
          $$QuizAttemptsTableUpdateCompanionBuilder,
          (QuizAttempt, $$QuizAttemptsTableReferences),
          QuizAttempt,
          PrefetchHooks Function({bool vocabularyId})
        > {
  $$QuizAttemptsTableTableManager(_$AppDatabase db, $QuizAttemptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuizAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuizAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuizAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> vocabularyId = const Value.absent(),
                Value<String> questionType = const Value.absent(),
                Value<String> userAnswer = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<String> attemptedAt = const Value.absent(),
              }) => QuizAttemptsCompanion(
                id: id,
                vocabularyId: vocabularyId,
                questionType: questionType,
                userAnswer: userAnswer,
                isCorrect: isCorrect,
                attemptedAt: attemptedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String vocabularyId,
                required String questionType,
                required String userAnswer,
                required bool isCorrect,
                required String attemptedAt,
              }) => QuizAttemptsCompanion.insert(
                id: id,
                vocabularyId: vocabularyId,
                questionType: questionType,
                userAnswer: userAnswer,
                isCorrect: isCorrect,
                attemptedAt: attemptedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuizAttemptsTable, QuizAttempt>(table),
                  $$QuizAttemptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vocabularyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vocabularyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vocabularyId,
                                referencedTable: $$QuizAttemptsTableReferences
                                    ._vocabularyIdTable(db),
                                referencedColumn: $$QuizAttemptsTableReferences
                                    ._vocabularyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuizAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuizAttemptsTable,
      QuizAttempt,
      $$QuizAttemptsTableFilterComposer,
      $$QuizAttemptsTableOrderingComposer,
      $$QuizAttemptsTableAnnotationComposer,
      $$QuizAttemptsTableCreateCompanionBuilder,
      $$QuizAttemptsTableUpdateCompanionBuilder,
      (QuizAttempt, $$QuizAttemptsTableReferences),
      QuizAttempt,
      PrefetchHooks Function({bool vocabularyId})
    >;
typedef $$DailyActivitiesTableCreateCompanionBuilder =
    DailyActivitiesCompanion Function({
      required String date,
      Value<int> wordsStudied,
      Value<int> correctAnswers,
      Value<int> wrongAnswers,
      Value<int> studyDurationSeconds,
      Value<int> rowid,
    });
typedef $$DailyActivitiesTableUpdateCompanionBuilder =
    DailyActivitiesCompanion Function({
      Value<String> date,
      Value<int> wordsStudied,
      Value<int> correctAnswers,
      Value<int> wrongAnswers,
      Value<int> studyDurationSeconds,
      Value<int> rowid,
    });

class $$DailyActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyActivitiesTable> {
  $$DailyActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordsStudied => $composableBuilder(
    column: $table.wordsStudied,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongAnswers => $composableBuilder(
    column: $table.wrongAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studyDurationSeconds => $composableBuilder(
    column: $table.studyDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyActivitiesTable> {
  $$DailyActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordsStudied => $composableBuilder(
    column: $table.wordsStudied,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongAnswers => $composableBuilder(
    column: $table.wrongAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studyDurationSeconds => $composableBuilder(
    column: $table.studyDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyActivitiesTable> {
  $$DailyActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get wordsStudied => $composableBuilder(
    column: $table.wordsStudied,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wrongAnswers => $composableBuilder(
    column: $table.wrongAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get studyDurationSeconds => $composableBuilder(
    column: $table.studyDurationSeconds,
    builder: (column) => column,
  );
}

class $$DailyActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyActivitiesTable,
          DailyActivity,
          $$DailyActivitiesTableFilterComposer,
          $$DailyActivitiesTableOrderingComposer,
          $$DailyActivitiesTableAnnotationComposer,
          $$DailyActivitiesTableCreateCompanionBuilder,
          $$DailyActivitiesTableUpdateCompanionBuilder,
          (
            DailyActivity,
            BaseReferences<_$AppDatabase, $DailyActivitiesTable, DailyActivity>,
          ),
          DailyActivity,
          PrefetchHooks Function()
        > {
  $$DailyActivitiesTableTableManager(
    _$AppDatabase db,
    $DailyActivitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> date = const Value.absent(),
                Value<int> wordsStudied = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> wrongAnswers = const Value.absent(),
                Value<int> studyDurationSeconds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyActivitiesCompanion(
                date: date,
                wordsStudied: wordsStudied,
                correctAnswers: correctAnswers,
                wrongAnswers: wrongAnswers,
                studyDurationSeconds: studyDurationSeconds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String date,
                Value<int> wordsStudied = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> wrongAnswers = const Value.absent(),
                Value<int> studyDurationSeconds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyActivitiesCompanion.insert(
                date: date,
                wordsStudied: wordsStudied,
                correctAnswers: correctAnswers,
                wrongAnswers: wrongAnswers,
                studyDurationSeconds: studyDurationSeconds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyActivitiesTable, DailyActivity>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DailyActivitiesTable,
                    DailyActivity
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyActivitiesTable,
      DailyActivity,
      $$DailyActivitiesTableFilterComposer,
      $$DailyActivitiesTableOrderingComposer,
      $$DailyActivitiesTableAnnotationComposer,
      $$DailyActivitiesTableCreateCompanionBuilder,
      $$DailyActivitiesTableUpdateCompanionBuilder,
      (
        DailyActivity,
        BaseReferences<_$AppDatabase, $DailyActivitiesTable, DailyActivity>,
      ),
      DailyActivity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VocabulariesTableTableManager get vocabularies =>
      $$VocabulariesTableTableManager(_db, _db.vocabularies);
  $$LearningProgressesTableTableManager get learningProgresses =>
      $$LearningProgressesTableTableManager(_db, _db.learningProgresses);
  $$QuizAttemptsTableTableManager get quizAttempts =>
      $$QuizAttemptsTableTableManager(_db, _db.quizAttempts);
  $$DailyActivitiesTableTableManager get dailyActivities =>
      $$DailyActivitiesTableTableManager(_db, _db.dailyActivities);
}
