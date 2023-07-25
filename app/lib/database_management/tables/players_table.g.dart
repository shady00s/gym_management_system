// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_table.dart';

// ignore_for_file: type=lint
class $PlayersTableTable extends PlayersTable
    with TableInfo<$PlayersTableTable, PlayersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
      'player_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _playerNameMeta =
      const VerificationMeta('playerName');
  @override
  late final GeneratedColumn<String> playerName = GeneratedColumn<String>(
      'player_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 90),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _playerPhoneNumberMeta =
      const VerificationMeta('playerPhoneNumber');
  @override
  late final GeneratedColumn<String> playerPhoneNumber =
      GeneratedColumn<String>('player_phone_number', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 11, maxTextLength: 11),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playerAgeMeta =
      const VerificationMeta('playerAge');
  @override
  late final GeneratedColumn<int> playerAge = GeneratedColumn<int>(
      'player_age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _playerFirstJoinDateMeta =
      const VerificationMeta('playerFirstJoinDate');
  @override
  late final GeneratedColumn<DateTime> playerFirstJoinDate =
      GeneratedColumn<DateTime>('player_first_join_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _playerGenderMeta =
      const VerificationMeta('playerGender');
  @override
  late final GeneratedColumn<String> playerGender = GeneratedColumn<String>(
      'player_gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subscriptionIdMeta =
      const VerificationMeta('subscriptionId');
  @override
  late final GeneratedColumn<int> subscriptionId = GeneratedColumn<int>(
      'subscription_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        playerId,
        playerName,
        playerPhoneNumber,
        imagePath,
        playerAge,
        playerFirstJoinDate,
        playerGender,
        subscriptionId
      ];
  @override
  String get aliasedName => _alias ?? 'players_table';
  @override
  String get actualTableName => 'players_table';
  @override
  VerificationContext validateIntegrity(Insertable<PlayersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('player_name')) {
      context.handle(
          _playerNameMeta,
          playerName.isAcceptableOrUnknown(
              data['player_name']!, _playerNameMeta));
    } else if (isInserting) {
      context.missing(_playerNameMeta);
    }
    if (data.containsKey('player_phone_number')) {
      context.handle(
          _playerPhoneNumberMeta,
          playerPhoneNumber.isAcceptableOrUnknown(
              data['player_phone_number']!, _playerPhoneNumberMeta));
    } else if (isInserting) {
      context.missing(_playerPhoneNumberMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('player_age')) {
      context.handle(_playerAgeMeta,
          playerAge.isAcceptableOrUnknown(data['player_age']!, _playerAgeMeta));
    } else if (isInserting) {
      context.missing(_playerAgeMeta);
    }
    if (data.containsKey('player_first_join_date')) {
      context.handle(
          _playerFirstJoinDateMeta,
          playerFirstJoinDate.isAcceptableOrUnknown(
              data['player_first_join_date']!, _playerFirstJoinDateMeta));
    } else if (isInserting) {
      context.missing(_playerFirstJoinDateMeta);
    }
    if (data.containsKey('player_gender')) {
      context.handle(
          _playerGenderMeta,
          playerGender.isAcceptableOrUnknown(
              data['player_gender']!, _playerGenderMeta));
    } else if (isInserting) {
      context.missing(_playerGenderMeta);
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
          _subscriptionIdMeta,
          subscriptionId.isAcceptableOrUnknown(
              data['subscription_id']!, _subscriptionIdMeta));
    } else if (isInserting) {
      context.missing(_subscriptionIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_id'])!,
      playerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_name'])!,
      playerPhoneNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}player_phone_number'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      playerAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_age'])!,
      playerFirstJoinDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}player_first_join_date'])!,
      playerGender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_gender'])!,
      subscriptionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subscription_id'])!,
    );
  }

  @override
  $PlayersTableTable createAlias(String alias) {
    return $PlayersTableTable(attachedDatabase, alias);
  }
}

class PlayersTableData extends DataClass
    implements Insertable<PlayersTableData> {
  final int id;
  final int playerId;
  final String playerName;
  final String playerPhoneNumber;
  final String imagePath;
  final int playerAge;
  final DateTime playerFirstJoinDate;
  final String playerGender;
  final int subscriptionId;
  const PlayersTableData(
      {required this.id,
      required this.playerId,
      required this.playerName,
      required this.playerPhoneNumber,
      required this.imagePath,
      required this.playerAge,
      required this.playerFirstJoinDate,
      required this.playerGender,
      required this.subscriptionId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['player_name'] = Variable<String>(playerName);
    map['player_phone_number'] = Variable<String>(playerPhoneNumber);
    map['image_path'] = Variable<String>(imagePath);
    map['player_age'] = Variable<int>(playerAge);
    map['player_first_join_date'] = Variable<DateTime>(playerFirstJoinDate);
    map['player_gender'] = Variable<String>(playerGender);
    map['subscription_id'] = Variable<int>(subscriptionId);
    return map;
  }

  PlayersTableCompanion toCompanion(bool nullToAbsent) {
    return PlayersTableCompanion(
      id: Value(id),
      playerId: Value(playerId),
      playerName: Value(playerName),
      playerPhoneNumber: Value(playerPhoneNumber),
      imagePath: Value(imagePath),
      playerAge: Value(playerAge),
      playerFirstJoinDate: Value(playerFirstJoinDate),
      playerGender: Value(playerGender),
      subscriptionId: Value(subscriptionId),
    );
  }

  factory PlayersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayersTableData(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      playerName: serializer.fromJson<String>(json['playerName']),
      playerPhoneNumber: serializer.fromJson<String>(json['playerPhoneNumber']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      playerAge: serializer.fromJson<int>(json['playerAge']),
      playerFirstJoinDate:
          serializer.fromJson<DateTime>(json['playerFirstJoinDate']),
      playerGender: serializer.fromJson<String>(json['playerGender']),
      subscriptionId: serializer.fromJson<int>(json['subscriptionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'playerName': serializer.toJson<String>(playerName),
      'playerPhoneNumber': serializer.toJson<String>(playerPhoneNumber),
      'imagePath': serializer.toJson<String>(imagePath),
      'playerAge': serializer.toJson<int>(playerAge),
      'playerFirstJoinDate': serializer.toJson<DateTime>(playerFirstJoinDate),
      'playerGender': serializer.toJson<String>(playerGender),
      'subscriptionId': serializer.toJson<int>(subscriptionId),
    };
  }

  PlayersTableData copyWith(
          {int? id,
          int? playerId,
          String? playerName,
          String? playerPhoneNumber,
          String? imagePath,
          int? playerAge,
          DateTime? playerFirstJoinDate,
          String? playerGender,
          int? subscriptionId}) =>
      PlayersTableData(
        id: id ?? this.id,
        playerId: playerId ?? this.playerId,
        playerName: playerName ?? this.playerName,
        playerPhoneNumber: playerPhoneNumber ?? this.playerPhoneNumber,
        imagePath: imagePath ?? this.imagePath,
        playerAge: playerAge ?? this.playerAge,
        playerFirstJoinDate: playerFirstJoinDate ?? this.playerFirstJoinDate,
        playerGender: playerGender ?? this.playerGender,
        subscriptionId: subscriptionId ?? this.subscriptionId,
      );
  @override
  String toString() {
    return (StringBuffer('PlayersTableData(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('playerName: $playerName, ')
          ..write('playerPhoneNumber: $playerPhoneNumber, ')
          ..write('imagePath: $imagePath, ')
          ..write('playerAge: $playerAge, ')
          ..write('playerFirstJoinDate: $playerFirstJoinDate, ')
          ..write('playerGender: $playerGender, ')
          ..write('subscriptionId: $subscriptionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerId, playerName, playerPhoneNumber,
      imagePath, playerAge, playerFirstJoinDate, playerGender, subscriptionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayersTableData &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.playerName == this.playerName &&
          other.playerPhoneNumber == this.playerPhoneNumber &&
          other.imagePath == this.imagePath &&
          other.playerAge == this.playerAge &&
          other.playerFirstJoinDate == this.playerFirstJoinDate &&
          other.playerGender == this.playerGender &&
          other.subscriptionId == this.subscriptionId);
}

class PlayersTableCompanion extends UpdateCompanion<PlayersTableData> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<String> playerName;
  final Value<String> playerPhoneNumber;
  final Value<String> imagePath;
  final Value<int> playerAge;
  final Value<DateTime> playerFirstJoinDate;
  final Value<String> playerGender;
  final Value<int> subscriptionId;
  const PlayersTableCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.playerName = const Value.absent(),
    this.playerPhoneNumber = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.playerAge = const Value.absent(),
    this.playerFirstJoinDate = const Value.absent(),
    this.playerGender = const Value.absent(),
    this.subscriptionId = const Value.absent(),
  });
  PlayersTableCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required String playerName,
    required String playerPhoneNumber,
    required String imagePath,
    required int playerAge,
    required DateTime playerFirstJoinDate,
    required String playerGender,
    required int subscriptionId,
  })  : playerId = Value(playerId),
        playerName = Value(playerName),
        playerPhoneNumber = Value(playerPhoneNumber),
        imagePath = Value(imagePath),
        playerAge = Value(playerAge),
        playerFirstJoinDate = Value(playerFirstJoinDate),
        playerGender = Value(playerGender),
        subscriptionId = Value(subscriptionId);
  static Insertable<PlayersTableData> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? playerName,
    Expression<String>? playerPhoneNumber,
    Expression<String>? imagePath,
    Expression<int>? playerAge,
    Expression<DateTime>? playerFirstJoinDate,
    Expression<String>? playerGender,
    Expression<int>? subscriptionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (playerName != null) 'player_name': playerName,
      if (playerPhoneNumber != null) 'player_phone_number': playerPhoneNumber,
      if (imagePath != null) 'image_path': imagePath,
      if (playerAge != null) 'player_age': playerAge,
      if (playerFirstJoinDate != null)
        'player_first_join_date': playerFirstJoinDate,
      if (playerGender != null) 'player_gender': playerGender,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
    });
  }

  PlayersTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? playerId,
      Value<String>? playerName,
      Value<String>? playerPhoneNumber,
      Value<String>? imagePath,
      Value<int>? playerAge,
      Value<DateTime>? playerFirstJoinDate,
      Value<String>? playerGender,
      Value<int>? subscriptionId}) {
    return PlayersTableCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      playerPhoneNumber: playerPhoneNumber ?? this.playerPhoneNumber,
      imagePath: imagePath ?? this.imagePath,
      playerAge: playerAge ?? this.playerAge,
      playerFirstJoinDate: playerFirstJoinDate ?? this.playerFirstJoinDate,
      playerGender: playerGender ?? this.playerGender,
      subscriptionId: subscriptionId ?? this.subscriptionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (playerName.present) {
      map['player_name'] = Variable<String>(playerName.value);
    }
    if (playerPhoneNumber.present) {
      map['player_phone_number'] = Variable<String>(playerPhoneNumber.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (playerAge.present) {
      map['player_age'] = Variable<int>(playerAge.value);
    }
    if (playerFirstJoinDate.present) {
      map['player_first_join_date'] =
          Variable<DateTime>(playerFirstJoinDate.value);
    }
    if (playerGender.present) {
      map['player_gender'] = Variable<String>(playerGender.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<int>(subscriptionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersTableCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('playerName: $playerName, ')
          ..write('playerPhoneNumber: $playerPhoneNumber, ')
          ..write('imagePath: $imagePath, ')
          ..write('playerAge: $playerAge, ')
          ..write('playerFirstJoinDate: $playerFirstJoinDate, ')
          ..write('playerGender: $playerGender, ')
          ..write('subscriptionId: $subscriptionId')
          ..write(')'))
        .toString();
  }
}

abstract class _$PlayersDatabase extends GeneratedDatabase {
  _$PlayersDatabase(QueryExecutor e) : super(e);
  late final $PlayersTableTable playersTable = $PlayersTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [playersTable];
}
