// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../database/database.dart';

// ignore_for_file: type=lint
class $ImageEntityTable extends ImageEntity
    with TableInfo<$ImageEntityTable, Image> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImageEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [title, date, url];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'image_entity';
  @override
  VerificationContext validateIntegrity(Insertable<Image> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  Image map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Image(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
    );
  }

  @override
  $ImageEntityTable createAlias(String alias) {
    return $ImageEntityTable(attachedDatabase, alias);
  }
}

class Image extends DataClass implements Insertable<Image> {
  final String title;
  final DateTime date;
  final String url;
  const Image({required this.title, required this.date, required this.url});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['date'] = Variable<DateTime>(date);
    map['url'] = Variable<String>(url);
    return map;
  }

  ImageEntityCompanion toCompanion(bool nullToAbsent) {
    return ImageEntityCompanion(
      title: Value(title),
      date: Value(date),
      url: Value(url),
    );
  }

  factory Image.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Image(
      title: serializer.fromJson<String>(json['title']),
      date: serializer.fromJson<DateTime>(json['date']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'date': serializer.toJson<DateTime>(date),
      'url': serializer.toJson<String>(url),
    };
  }

  Image copyWith({String? title, DateTime? date, String? url}) => Image(
        title: title ?? this.title,
        date: date ?? this.date,
        url: url ?? this.url,
      );
  @override
  String toString() {
    return (StringBuffer('Image(')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, date, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Image &&
          other.title == this.title &&
          other.date == this.date &&
          other.url == this.url);
}

class ImageEntityCompanion extends UpdateCompanion<Image> {
  final Value<String> title;
  final Value<DateTime> date;
  final Value<String> url;
  final Value<int> rowid;
  const ImageEntityCompanion({
    this.title = const Value.absent(),
    this.date = const Value.absent(),
    this.url = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImageEntityCompanion.insert({
    required String title,
    required DateTime date,
    required String url,
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        date = Value(date),
        url = Value(url);
  static Insertable<Image> custom({
    Expression<String>? title,
    Expression<DateTime>? date,
    Expression<String>? url,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (date != null) 'date': date,
      if (url != null) 'url': url,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImageEntityCompanion copyWith(
      {Value<String>? title,
      Value<DateTime>? date,
      Value<String>? url,
      Value<int>? rowid}) {
    return ImageEntityCompanion(
      title: title ?? this.title,
      date: date ?? this.date,
      url: url ?? this.url,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageEntityCompanion(')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('url: $url, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $ImageEntityTable imageEntity = $ImageEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [imageEntity];
}
