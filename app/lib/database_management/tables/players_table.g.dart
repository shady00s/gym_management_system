// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_table.dart';

// ignore_for_file: type=lint
class Players extends Table with TableInfo<Players, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Players(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
      'player_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _playerNameMeta =
      const VerificationMeta('playerName');
  late final GeneratedColumn<String> playerName = GeneratedColumn<String>(
      'player_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _playerPhoneNumberMeta =
      const VerificationMeta('playerPhoneNumber');
  late final GeneratedColumn<int> playerPhoneNumber = GeneratedColumn<int>(
      'player_phone_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _playerAgeMeta =
      const VerificationMeta('playerAge');
  late final GeneratedColumn<int> playerAge = GeneratedColumn<int>(
      'player_age', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _playerFirstJoinDateMeta =
      const VerificationMeta('playerFirstJoinDate');
  late final GeneratedColumn<String> playerFirstJoinDate =
      GeneratedColumn<String>('player_first_join_date', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  static const VerificationMeta _playerGenderMeta =
      const VerificationMeta('playerGender');
  late final GeneratedColumn<String> playerGender = GeneratedColumn<String>(
      'player_gender', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _subscriptionIdMeta =
      const VerificationMeta('subscriptionId');
  late final GeneratedColumn<int> subscriptionId = GeneratedColumn<int>(
      'subscription_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
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
  String get aliasedName => _alias ?? 'Players';
  @override
  String get actualTableName => 'Players';
  @override
  VerificationContext validateIntegrity(Insertable<Player> instance,
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
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_id'])!,
      playerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_name'])!,
      playerPhoneNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}player_phone_number'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      playerAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_age'])!,
      playerFirstJoinDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}player_first_join_date'])!,
      playerGender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_gender'])!,
      subscriptionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subscription_id'])!,
    );
  }

  @override
  Players createAlias(String alias) {
    return Players(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final int playerId;
  final String playerName;
  final int playerPhoneNumber;
  final String imagePath;
  final int playerAge;
  final String playerFirstJoinDate;
  final String playerGender;
  final int subscriptionId;
  const Player(
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
    map['player_phone_number'] = Variable<int>(playerPhoneNumber);
    map['image_path'] = Variable<String>(imagePath);
    map['player_age'] = Variable<int>(playerAge);
    map['player_first_join_date'] = Variable<String>(playerFirstJoinDate);
    map['player_gender'] = Variable<String>(playerGender);
    map['subscription_id'] = Variable<int>(subscriptionId);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
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

  factory Player.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['player_id']),
      playerName: serializer.fromJson<String>(json['player_name']),
      playerPhoneNumber: serializer.fromJson<int>(json['player_phone_number']),
      imagePath: serializer.fromJson<String>(json['image_path']),
      playerAge: serializer.fromJson<int>(json['player_age']),
      playerFirstJoinDate:
          serializer.fromJson<String>(json['player_first_join_date']),
      playerGender: serializer.fromJson<String>(json['player_gender']),
      subscriptionId: serializer.fromJson<int>(json['subscription_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'player_id': serializer.toJson<int>(playerId),
      'player_name': serializer.toJson<String>(playerName),
      'player_phone_number': serializer.toJson<int>(playerPhoneNumber),
      'image_path': serializer.toJson<String>(imagePath),
      'player_age': serializer.toJson<int>(playerAge),
      'player_first_join_date': serializer.toJson<String>(playerFirstJoinDate),
      'player_gender': serializer.toJson<String>(playerGender),
      'subscription_id': serializer.toJson<int>(subscriptionId),
    };
  }

  Player copyWith(
          {int? id,
          int? playerId,
          String? playerName,
          int? playerPhoneNumber,
          String? imagePath,
          int? playerAge,
          String? playerFirstJoinDate,
          String? playerGender,
          int? subscriptionId}) =>
      Player(
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
    return (StringBuffer('Player(')
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
      (other is Player &&
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

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<String> playerName;
  final Value<int> playerPhoneNumber;
  final Value<String> imagePath;
  final Value<int> playerAge;
  final Value<String> playerFirstJoinDate;
  final Value<String> playerGender;
  final Value<int> subscriptionId;
  const PlayersCompanion({
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
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required String playerName,
    required int playerPhoneNumber,
    required String imagePath,
    required int playerAge,
    required String playerFirstJoinDate,
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
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? playerName,
    Expression<int>? playerPhoneNumber,
    Expression<String>? imagePath,
    Expression<int>? playerAge,
    Expression<String>? playerFirstJoinDate,
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

  PlayersCompanion copyWith(
      {Value<int>? id,
      Value<int>? playerId,
      Value<String>? playerName,
      Value<int>? playerPhoneNumber,
      Value<String>? imagePath,
      Value<int>? playerAge,
      Value<String>? playerFirstJoinDate,
      Value<String>? playerGender,
      Value<int>? subscriptionId}) {
    return PlayersCompanion(
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
      map['player_phone_number'] = Variable<int>(playerPhoneNumber.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (playerAge.present) {
      map['player_age'] = Variable<int>(playerAge.value);
    }
    if (playerFirstJoinDate.present) {
      map['player_first_join_date'] =
          Variable<String>(playerFirstJoinDate.value);
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
    return (StringBuffer('PlayersCompanion(')
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

class PlayersSubscriptions extends Table
    with TableInfo<PlayersSubscriptions, PlayersSubscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PlayersSubscriptions(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _subIdMeta = const VerificationMeta('subId');
  late final GeneratedColumn<int> subId = GeneratedColumn<int>(
      'sub_id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _playerSubscriptionIdMeta =
      const VerificationMeta('playerSubscriptionId');
  late final GeneratedColumn<int> playerSubscriptionId = GeneratedColumn<int>(
      'player_subscription_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _beginningDateMeta =
      const VerificationMeta('beginningDate');
  late final GeneratedColumn<DateTime> beginningDate =
      GeneratedColumn<DateTime>('beginning_date', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  late final GeneratedColumn<int> billId = GeneratedColumn<int>(
      'billId', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _billValueMeta =
      const VerificationMeta('billValue');
  late final GeneratedColumn<int> billValue = GeneratedColumn<int>(
      'billValue', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _billCollectorMeta =
      const VerificationMeta('billCollector');
  late final GeneratedColumn<String> billCollector = GeneratedColumn<String>(
      'billCollector', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        subId,
        playerSubscriptionId,
        beginningDate,
        endDate,
        billId,
        billValue,
        duration,
        billCollector
      ];
  @override
  String get aliasedName => _alias ?? 'PlayersSubscriptions';
  @override
  String get actualTableName => 'PlayersSubscriptions';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlayersSubscription> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sub_id')) {
      context.handle(
          _subIdMeta, subId.isAcceptableOrUnknown(data['sub_id']!, _subIdMeta));
    }
    if (data.containsKey('player_subscription_id')) {
      context.handle(
          _playerSubscriptionIdMeta,
          playerSubscriptionId.isAcceptableOrUnknown(
              data['player_subscription_id']!, _playerSubscriptionIdMeta));
    } else if (isInserting) {
      context.missing(_playerSubscriptionIdMeta);
    }
    if (data.containsKey('beginning_date')) {
      context.handle(
          _beginningDateMeta,
          beginningDate.isAcceptableOrUnknown(
              data['beginning_date']!, _beginningDateMeta));
    } else if (isInserting) {
      context.missing(_beginningDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('billId')) {
      context.handle(_billIdMeta,
          billId.isAcceptableOrUnknown(data['billId']!, _billIdMeta));
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('billValue')) {
      context.handle(_billValueMeta,
          billValue.isAcceptableOrUnknown(data['billValue']!, _billValueMeta));
    } else if (isInserting) {
      context.missing(_billValueMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('billCollector')) {
      context.handle(
          _billCollectorMeta,
          billCollector.isAcceptableOrUnknown(
              data['billCollector']!, _billCollectorMeta));
    } else if (isInserting) {
      context.missing(_billCollectorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {subId};
  @override
  PlayersSubscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayersSubscription(
      subId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sub_id']),
      playerSubscriptionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}player_subscription_id'])!,
      beginningDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}beginning_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
      billId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}billId'])!,
      billValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}billValue'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      billCollector: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}billCollector'])!,
    );
  }

  @override
  PlayersSubscriptions createAlias(String alias) {
    return PlayersSubscriptions(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class PlayersSubscription extends DataClass
    implements Insertable<PlayersSubscription> {
  final int? subId;
  final int playerSubscriptionId;
  final DateTime beginningDate;
  final DateTime endDate;
  final int billId;
  final int billValue;
  final int duration;
  final String billCollector;
  const PlayersSubscription(
      {this.subId,
      required this.playerSubscriptionId,
      required this.beginningDate,
      required this.endDate,
      required this.billId,
      required this.billValue,
      required this.duration,
      required this.billCollector});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || subId != null) {
      map['sub_id'] = Variable<int>(subId);
    }
    map['player_subscription_id'] = Variable<int>(playerSubscriptionId);
    map['beginning_date'] = Variable<DateTime>(beginningDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['billId'] = Variable<int>(billId);
    map['billValue'] = Variable<int>(billValue);
    map['duration'] = Variable<int>(duration);
    map['billCollector'] = Variable<String>(billCollector);
    return map;
  }

  PlayersSubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return PlayersSubscriptionsCompanion(
      subId:
          subId == null && nullToAbsent ? const Value.absent() : Value(subId),
      playerSubscriptionId: Value(playerSubscriptionId),
      beginningDate: Value(beginningDate),
      endDate: Value(endDate),
      billId: Value(billId),
      billValue: Value(billValue),
      duration: Value(duration),
      billCollector: Value(billCollector),
    );
  }

  factory PlayersSubscription.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayersSubscription(
      subId: serializer.fromJson<int?>(json['sub_id']),
      playerSubscriptionId:
          serializer.fromJson<int>(json['player_subscription_id']),
      beginningDate: serializer.fromJson<DateTime>(json['beginning_date']),
      endDate: serializer.fromJson<DateTime>(json['end_date']),
      billId: serializer.fromJson<int>(json['billId']),
      billValue: serializer.fromJson<int>(json['billValue']),
      duration: serializer.fromJson<int>(json['duration']),
      billCollector: serializer.fromJson<String>(json['billCollector']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sub_id': serializer.toJson<int?>(subId),
      'player_subscription_id': serializer.toJson<int>(playerSubscriptionId),
      'beginning_date': serializer.toJson<DateTime>(beginningDate),
      'end_date': serializer.toJson<DateTime>(endDate),
      'billId': serializer.toJson<int>(billId),
      'billValue': serializer.toJson<int>(billValue),
      'duration': serializer.toJson<int>(duration),
      'billCollector': serializer.toJson<String>(billCollector),
    };
  }

  PlayersSubscription copyWith(
          {Value<int?> subId = const Value.absent(),
          int? playerSubscriptionId,
          DateTime? beginningDate,
          DateTime? endDate,
          int? billId,
          int? billValue,
          int? duration,
          String? billCollector}) =>
      PlayersSubscription(
        subId: subId.present ? subId.value : this.subId,
        playerSubscriptionId: playerSubscriptionId ?? this.playerSubscriptionId,
        beginningDate: beginningDate ?? this.beginningDate,
        endDate: endDate ?? this.endDate,
        billId: billId ?? this.billId,
        billValue: billValue ?? this.billValue,
        duration: duration ?? this.duration,
        billCollector: billCollector ?? this.billCollector,
      );
  @override
  String toString() {
    return (StringBuffer('PlayersSubscription(')
          ..write('subId: $subId, ')
          ..write('playerSubscriptionId: $playerSubscriptionId, ')
          ..write('beginningDate: $beginningDate, ')
          ..write('endDate: $endDate, ')
          ..write('billId: $billId, ')
          ..write('billValue: $billValue, ')
          ..write('duration: $duration, ')
          ..write('billCollector: $billCollector')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(subId, playerSubscriptionId, beginningDate,
      endDate, billId, billValue, duration, billCollector);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayersSubscription &&
          other.subId == this.subId &&
          other.playerSubscriptionId == this.playerSubscriptionId &&
          other.beginningDate == this.beginningDate &&
          other.endDate == this.endDate &&
          other.billId == this.billId &&
          other.billValue == this.billValue &&
          other.duration == this.duration &&
          other.billCollector == this.billCollector);
}

class PlayersSubscriptionsCompanion
    extends UpdateCompanion<PlayersSubscription> {
  final Value<int?> subId;
  final Value<int> playerSubscriptionId;
  final Value<DateTime> beginningDate;
  final Value<DateTime> endDate;
  final Value<int> billId;
  final Value<int> billValue;
  final Value<int> duration;
  final Value<String> billCollector;
  const PlayersSubscriptionsCompanion({
    this.subId = const Value.absent(),
    this.playerSubscriptionId = const Value.absent(),
    this.beginningDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.billId = const Value.absent(),
    this.billValue = const Value.absent(),
    this.duration = const Value.absent(),
    this.billCollector = const Value.absent(),
  });
  PlayersSubscriptionsCompanion.insert({
    this.subId = const Value.absent(),
    required int playerSubscriptionId,
    required DateTime beginningDate,
    required DateTime endDate,
    required int billId,
    required int billValue,
    required int duration,
    required String billCollector,
  })  : playerSubscriptionId = Value(playerSubscriptionId),
        beginningDate = Value(beginningDate),
        endDate = Value(endDate),
        billId = Value(billId),
        billValue = Value(billValue),
        duration = Value(duration),
        billCollector = Value(billCollector);
  static Insertable<PlayersSubscription> custom({
    Expression<int>? subId,
    Expression<int>? playerSubscriptionId,
    Expression<DateTime>? beginningDate,
    Expression<DateTime>? endDate,
    Expression<int>? billId,
    Expression<int>? billValue,
    Expression<int>? duration,
    Expression<String>? billCollector,
  }) {
    return RawValuesInsertable({
      if (subId != null) 'sub_id': subId,
      if (playerSubscriptionId != null)
        'player_subscription_id': playerSubscriptionId,
      if (beginningDate != null) 'beginning_date': beginningDate,
      if (endDate != null) 'end_date': endDate,
      if (billId != null) 'billId': billId,
      if (billValue != null) 'billValue': billValue,
      if (duration != null) 'duration': duration,
      if (billCollector != null) 'billCollector': billCollector,
    });
  }

  PlayersSubscriptionsCompanion copyWith(
      {Value<int?>? subId,
      Value<int>? playerSubscriptionId,
      Value<DateTime>? beginningDate,
      Value<DateTime>? endDate,
      Value<int>? billId,
      Value<int>? billValue,
      Value<int>? duration,
      Value<String>? billCollector}) {
    return PlayersSubscriptionsCompanion(
      subId: subId ?? this.subId,
      playerSubscriptionId: playerSubscriptionId ?? this.playerSubscriptionId,
      beginningDate: beginningDate ?? this.beginningDate,
      endDate: endDate ?? this.endDate,
      billId: billId ?? this.billId,
      billValue: billValue ?? this.billValue,
      duration: duration ?? this.duration,
      billCollector: billCollector ?? this.billCollector,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (subId.present) {
      map['sub_id'] = Variable<int>(subId.value);
    }
    if (playerSubscriptionId.present) {
      map['player_subscription_id'] = Variable<int>(playerSubscriptionId.value);
    }
    if (beginningDate.present) {
      map['beginning_date'] = Variable<DateTime>(beginningDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (billId.present) {
      map['billId'] = Variable<int>(billId.value);
    }
    if (billValue.present) {
      map['billValue'] = Variable<int>(billValue.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (billCollector.present) {
      map['billCollector'] = Variable<String>(billCollector.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersSubscriptionsCompanion(')
          ..write('subId: $subId, ')
          ..write('playerSubscriptionId: $playerSubscriptionId, ')
          ..write('beginningDate: $beginningDate, ')
          ..write('endDate: $endDate, ')
          ..write('billId: $billId, ')
          ..write('billValue: $billValue, ')
          ..write('duration: $duration, ')
          ..write('billCollector: $billCollector')
          ..write(')'))
        .toString();
  }
}

abstract class _$PlayersDatabase extends GeneratedDatabase {
  _$PlayersDatabase(QueryExecutor e) : super(e);
  late final Players players = Players(this);
  late final PlayersSubscriptions playersSubscriptions =
      PlayersSubscriptions(this);
  Selectable<Player> allPlayers() {
    return customSelect('SELECT * FROM Players', variables: [], readsFrom: {
      players,
    }).asyncMap(players.mapFromRow);
  }

  Selectable<GetAllNamesResult> getAllNames() {
    return customSelect(
        'SELECT player_id, player_name FROM PLAYERS ORDER BY player_id ASC',
        variables: [],
        readsFrom: {
          players,
        }).map((QueryRow row) {
      return GetAllNamesResult(
        playerId: row.read<int>('player_id'),
        playerName: row.read<String>('player_name'),
      );
    });
  }

  Selectable<PlayersSubscription> allSubscriptions() {
    return customSelect('SELECT * FROM PlayersSubscriptions',
        variables: [],
        readsFrom: {
          playersSubscriptions,
        }).asyncMap(playersSubscriptions.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [players, playersSubscriptions];
}

class GetAllNamesResult {
  final int playerId;
  final String playerName;
  GetAllNamesResult({
    required this.playerId,
    required this.playerName,
  });
}
