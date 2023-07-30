// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_table.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
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
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 90),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _playerPhoneNumberMeta =
      const VerificationMeta('playerPhoneNumber');
  @override
  late final GeneratedColumn<int> playerPhoneNumber = GeneratedColumn<int>(
      'player_phone_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  String get aliasedName => _alias ?? 'players';
  @override
  String get actualTableName => 'players';
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
          DriftSqlType.dateTime,
          data['${effectivePrefix}player_first_join_date'])!,
      playerGender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_gender'])!,
      subscriptionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subscription_id'])!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final int playerId;
  final String playerName;
  final int playerPhoneNumber;
  final String imagePath;
  final int playerAge;
  final DateTime playerFirstJoinDate;
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
    map['player_first_join_date'] = Variable<DateTime>(playerFirstJoinDate);
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
      playerId: serializer.fromJson<int>(json['playerId']),
      playerName: serializer.fromJson<String>(json['playerName']),
      playerPhoneNumber: serializer.fromJson<int>(json['playerPhoneNumber']),
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
      'playerPhoneNumber': serializer.toJson<int>(playerPhoneNumber),
      'imagePath': serializer.toJson<String>(imagePath),
      'playerAge': serializer.toJson<int>(playerAge),
      'playerFirstJoinDate': serializer.toJson<DateTime>(playerFirstJoinDate),
      'playerGender': serializer.toJson<String>(playerGender),
      'subscriptionId': serializer.toJson<int>(subscriptionId),
    };
  }

  Player copyWith(
          {int? id,
          int? playerId,
          String? playerName,
          int? playerPhoneNumber,
          String? imagePath,
          int? playerAge,
          DateTime? playerFirstJoinDate,
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
  final Value<DateTime> playerFirstJoinDate;
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
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? playerName,
    Expression<int>? playerPhoneNumber,
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

  PlayersCompanion copyWith(
      {Value<int>? id,
      Value<int>? playerId,
      Value<String>? playerName,
      Value<int>? playerPhoneNumber,
      Value<String>? imagePath,
      Value<int>? playerAge,
      Value<DateTime>? playerFirstJoinDate,
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

class $PlayersSubscriptionsTable extends PlayersSubscriptions
    with TableInfo<$PlayersSubscriptionsTable, PlayersSubscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersSubscriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _subIdMeta = const VerificationMeta('subId');
  @override
  late final GeneratedColumn<int> subId = GeneratedColumn<int>(
      'sub_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _playerSubscriptionIdMeta =
      const VerificationMeta('playerSubscriptionId');
  @override
  late final GeneratedColumn<int> playerSubscriptionId = GeneratedColumn<int>(
      'player_subscription_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _beginningDateMeta =
      const VerificationMeta('beginningDate');
  @override
  late final GeneratedColumn<String> beginningDate = GeneratedColumn<String>(
      'beginning_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<int> billId = GeneratedColumn<int>(
      'bill_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _billValueMeta =
      const VerificationMeta('billValue');
  @override
  late final GeneratedColumn<int> billValue = GeneratedColumn<int>(
      'bill_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _billCollectorMeta =
      const VerificationMeta('billCollector');
  @override
  late final GeneratedColumn<String> billCollector = GeneratedColumn<String>(
      'bill_collector', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        subId,
        playerSubscriptionId,
        beginningDate,
        endDate,
        billId,
        duration,
        billValue,
        billCollector
      ];
  @override
  String get aliasedName => _alias ?? 'players_subscriptions';
  @override
  String get actualTableName => 'players_subscriptions';
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
    if (data.containsKey('bill_id')) {
      context.handle(_billIdMeta,
          billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta));
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('bill_value')) {
      context.handle(_billValueMeta,
          billValue.isAcceptableOrUnknown(data['bill_value']!, _billValueMeta));
    } else if (isInserting) {
      context.missing(_billValueMeta);
    }
    if (data.containsKey('bill_collector')) {
      context.handle(
          _billCollectorMeta,
          billCollector.isAcceptableOrUnknown(
              data['bill_collector']!, _billCollectorMeta));
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
          .read(DriftSqlType.int, data['${effectivePrefix}sub_id'])!,
      playerSubscriptionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}player_subscription_id'])!,
      beginningDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}beginning_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date'])!,
      billId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bill_id'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      billValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bill_value'])!,
      billCollector: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bill_collector'])!,
    );
  }

  @override
  $PlayersSubscriptionsTable createAlias(String alias) {
    return $PlayersSubscriptionsTable(attachedDatabase, alias);
  }
}

class PlayersSubscription extends DataClass
    implements Insertable<PlayersSubscription> {
  final int subId;
  final int playerSubscriptionId;
  final String beginningDate;
  final String endDate;
  final int billId;
  final int duration;
  final int billValue;
  final String billCollector;
  const PlayersSubscription(
      {required this.subId,
      required this.playerSubscriptionId,
      required this.beginningDate,
      required this.endDate,
      required this.billId,
      required this.duration,
      required this.billValue,
      required this.billCollector});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sub_id'] = Variable<int>(subId);
    map['player_subscription_id'] = Variable<int>(playerSubscriptionId);
    map['beginning_date'] = Variable<String>(beginningDate);
    map['end_date'] = Variable<String>(endDate);
    map['bill_id'] = Variable<int>(billId);
    map['duration'] = Variable<int>(duration);
    map['bill_value'] = Variable<int>(billValue);
    map['bill_collector'] = Variable<String>(billCollector);
    return map;
  }

  PlayersSubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return PlayersSubscriptionsCompanion(
      subId: Value(subId),
      playerSubscriptionId: Value(playerSubscriptionId),
      beginningDate: Value(beginningDate),
      endDate: Value(endDate),
      billId: Value(billId),
      duration: Value(duration),
      billValue: Value(billValue),
      billCollector: Value(billCollector),
    );
  }

  factory PlayersSubscription.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayersSubscription(
      subId: serializer.fromJson<int>(json['subId']),
      playerSubscriptionId:
          serializer.fromJson<int>(json['playerSubscriptionId']),
      beginningDate: serializer.fromJson<String>(json['beginningDate']),
      endDate: serializer.fromJson<String>(json['endDate']),
      billId: serializer.fromJson<int>(json['billId']),
      duration: serializer.fromJson<int>(json['duration']),
      billValue: serializer.fromJson<int>(json['billValue']),
      billCollector: serializer.fromJson<String>(json['billCollector']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'subId': serializer.toJson<int>(subId),
      'playerSubscriptionId': serializer.toJson<int>(playerSubscriptionId),
      'beginningDate': serializer.toJson<String>(beginningDate),
      'endDate': serializer.toJson<String>(endDate),
      'billId': serializer.toJson<int>(billId),
      'duration': serializer.toJson<int>(duration),
      'billValue': serializer.toJson<int>(billValue),
      'billCollector': serializer.toJson<String>(billCollector),
    };
  }

  PlayersSubscription copyWith(
          {int? subId,
          int? playerSubscriptionId,
          String? beginningDate,
          String? endDate,
          int? billId,
          int? duration,
          int? billValue,
          String? billCollector}) =>
      PlayersSubscription(
        subId: subId ?? this.subId,
        playerSubscriptionId: playerSubscriptionId ?? this.playerSubscriptionId,
        beginningDate: beginningDate ?? this.beginningDate,
        endDate: endDate ?? this.endDate,
        billId: billId ?? this.billId,
        duration: duration ?? this.duration,
        billValue: billValue ?? this.billValue,
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
          ..write('duration: $duration, ')
          ..write('billValue: $billValue, ')
          ..write('billCollector: $billCollector')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(subId, playerSubscriptionId, beginningDate,
      endDate, billId, duration, billValue, billCollector);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayersSubscription &&
          other.subId == this.subId &&
          other.playerSubscriptionId == this.playerSubscriptionId &&
          other.beginningDate == this.beginningDate &&
          other.endDate == this.endDate &&
          other.billId == this.billId &&
          other.duration == this.duration &&
          other.billValue == this.billValue &&
          other.billCollector == this.billCollector);
}

class PlayersSubscriptionsCompanion
    extends UpdateCompanion<PlayersSubscription> {
  final Value<int> subId;
  final Value<int> playerSubscriptionId;
  final Value<String> beginningDate;
  final Value<String> endDate;
  final Value<int> billId;
  final Value<int> duration;
  final Value<int> billValue;
  final Value<String> billCollector;
  const PlayersSubscriptionsCompanion({
    this.subId = const Value.absent(),
    this.playerSubscriptionId = const Value.absent(),
    this.beginningDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.billId = const Value.absent(),
    this.duration = const Value.absent(),
    this.billValue = const Value.absent(),
    this.billCollector = const Value.absent(),
  });
  PlayersSubscriptionsCompanion.insert({
    this.subId = const Value.absent(),
    required int playerSubscriptionId,
    required String beginningDate,
    required String endDate,
    required int billId,
    required int duration,
    required int billValue,
    required String billCollector,
  })  : playerSubscriptionId = Value(playerSubscriptionId),
        beginningDate = Value(beginningDate),
        endDate = Value(endDate),
        billId = Value(billId),
        duration = Value(duration),
        billValue = Value(billValue),
        billCollector = Value(billCollector);
  static Insertable<PlayersSubscription> custom({
    Expression<int>? subId,
    Expression<int>? playerSubscriptionId,
    Expression<String>? beginningDate,
    Expression<String>? endDate,
    Expression<int>? billId,
    Expression<int>? duration,
    Expression<int>? billValue,
    Expression<String>? billCollector,
  }) {
    return RawValuesInsertable({
      if (subId != null) 'sub_id': subId,
      if (playerSubscriptionId != null)
        'player_subscription_id': playerSubscriptionId,
      if (beginningDate != null) 'beginning_date': beginningDate,
      if (endDate != null) 'end_date': endDate,
      if (billId != null) 'bill_id': billId,
      if (duration != null) 'duration': duration,
      if (billValue != null) 'bill_value': billValue,
      if (billCollector != null) 'bill_collector': billCollector,
    });
  }

  PlayersSubscriptionsCompanion copyWith(
      {Value<int>? subId,
      Value<int>? playerSubscriptionId,
      Value<String>? beginningDate,
      Value<String>? endDate,
      Value<int>? billId,
      Value<int>? duration,
      Value<int>? billValue,
      Value<String>? billCollector}) {
    return PlayersSubscriptionsCompanion(
      subId: subId ?? this.subId,
      playerSubscriptionId: playerSubscriptionId ?? this.playerSubscriptionId,
      beginningDate: beginningDate ?? this.beginningDate,
      endDate: endDate ?? this.endDate,
      billId: billId ?? this.billId,
      duration: duration ?? this.duration,
      billValue: billValue ?? this.billValue,
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
      map['beginning_date'] = Variable<String>(beginningDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<int>(billId.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (billValue.present) {
      map['bill_value'] = Variable<int>(billValue.value);
    }
    if (billCollector.present) {
      map['bill_collector'] = Variable<String>(billCollector.value);
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
          ..write('duration: $duration, ')
          ..write('billValue: $billValue, ')
          ..write('billCollector: $billCollector')
          ..write(')'))
        .toString();
  }
}

abstract class _$PlayersDatabase extends GeneratedDatabase {
  _$PlayersDatabase(QueryExecutor e) : super(e);
  late final $PlayersTable players = $PlayersTable(this);
  late final $PlayersSubscriptionsTable playersSubscriptions =
      $PlayersSubscriptionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [players, playersSubscriptions];
}
