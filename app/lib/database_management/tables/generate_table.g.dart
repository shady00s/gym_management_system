// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_table.dart';

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
  static const VerificationMeta _playerIndexIdMeta =
      const VerificationMeta('playerIndexId');
  late final GeneratedColumn<int> playerIndexId = GeneratedColumn<int>(
      'player_index_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
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
  late final GeneratedColumn<DateTime> playerFirstJoinDate =
      GeneratedColumn<DateTime>('player_first_join_date', aliasedName, false,
          type: DriftSqlType.dateTime,
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
        playerIndexId,
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
    if (data.containsKey('player_index_id')) {
      context.handle(
          _playerIndexIdMeta,
          playerIndexId.isAcceptableOrUnknown(
              data['player_index_id']!, _playerIndexIdMeta));
    } else if (isInserting) {
      context.missing(_playerIndexIdMeta);
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
      playerIndexId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_index_id'])!,
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
  Players createAlias(String alias) {
    return Players(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final int playerIndexId;
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
      required this.playerIndexId,
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
    map['player_index_id'] = Variable<int>(playerIndexId);
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
      playerIndexId: Value(playerIndexId),
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
      playerIndexId: serializer.fromJson<int>(json['player_index_id']),
      playerId: serializer.fromJson<int>(json['player_id']),
      playerName: serializer.fromJson<String>(json['player_name']),
      playerPhoneNumber: serializer.fromJson<int>(json['player_phone_number']),
      imagePath: serializer.fromJson<String>(json['image_path']),
      playerAge: serializer.fromJson<int>(json['player_age']),
      playerFirstJoinDate:
          serializer.fromJson<DateTime>(json['player_first_join_date']),
      playerGender: serializer.fromJson<String>(json['player_gender']),
      subscriptionId: serializer.fromJson<int>(json['subscription_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'player_index_id': serializer.toJson<int>(playerIndexId),
      'player_id': serializer.toJson<int>(playerId),
      'player_name': serializer.toJson<String>(playerName),
      'player_phone_number': serializer.toJson<int>(playerPhoneNumber),
      'image_path': serializer.toJson<String>(imagePath),
      'player_age': serializer.toJson<int>(playerAge),
      'player_first_join_date':
          serializer.toJson<DateTime>(playerFirstJoinDate),
      'player_gender': serializer.toJson<String>(playerGender),
      'subscription_id': serializer.toJson<int>(subscriptionId),
    };
  }

  Player copyWith(
          {int? id,
          int? playerIndexId,
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
        playerIndexId: playerIndexId ?? this.playerIndexId,
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
          ..write('playerIndexId: $playerIndexId, ')
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
  int get hashCode => Object.hash(
      id,
      playerIndexId,
      playerId,
      playerName,
      playerPhoneNumber,
      imagePath,
      playerAge,
      playerFirstJoinDate,
      playerGender,
      subscriptionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.playerIndexId == this.playerIndexId &&
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
  final Value<int> playerIndexId;
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
    this.playerIndexId = const Value.absent(),
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
    required int playerIndexId,
    required int playerId,
    required String playerName,
    required int playerPhoneNumber,
    required String imagePath,
    required int playerAge,
    required DateTime playerFirstJoinDate,
    required String playerGender,
    required int subscriptionId,
  })  : playerIndexId = Value(playerIndexId),
        playerId = Value(playerId),
        playerName = Value(playerName),
        playerPhoneNumber = Value(playerPhoneNumber),
        imagePath = Value(imagePath),
        playerAge = Value(playerAge),
        playerFirstJoinDate = Value(playerFirstJoinDate),
        playerGender = Value(playerGender),
        subscriptionId = Value(subscriptionId);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<int>? playerIndexId,
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
      if (playerIndexId != null) 'player_index_id': playerIndexId,
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
      Value<int>? playerIndexId,
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
      playerIndexId: playerIndexId ?? this.playerIndexId,
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
    if (playerIndexId.present) {
      map['player_index_id'] = Variable<int>(playerIndexId.value);
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
          ..write('playerIndexId: $playerIndexId, ')
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

class EmployeesTable extends Table
    with TableInfo<EmployeesTable, EmployeesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  late final GeneratedColumn<int> employeeId = GeneratedColumn<int>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _employeeNameMeta =
      const VerificationMeta('employeeName');
  late final GeneratedColumn<String> employeeName = GeneratedColumn<String>(
      'employee_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _employeePhoneNumberMeta =
      const VerificationMeta('employeePhoneNumber');
  late final GeneratedColumn<int> employeePhoneNumber = GeneratedColumn<int>(
      'employee_phone_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _employeeSpecializationMeta =
      const VerificationMeta('employeeSpecialization');
  late final GeneratedColumn<String> employeeSpecialization =
      GeneratedColumn<String>('employee_specialization', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  static const VerificationMeta _employeePositionMeta =
      const VerificationMeta('employeePosition');
  late final GeneratedColumn<String> employeePosition = GeneratedColumn<String>(
      'employee_position', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _employeeSalaryMeta =
      const VerificationMeta('employeeSalary');
  late final GeneratedColumn<double> employeeSalary = GeneratedColumn<double>(
      'employee_salary', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0.0',
      defaultValue: const CustomExpression('0.0'));
  static const VerificationMeta _employeeAddressMeta =
      const VerificationMeta('employeeAddress');
  late final GeneratedColumn<String> employeeAddress = GeneratedColumn<String>(
      'employee_address', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        employeeId,
        employeeName,
        employeePhoneNumber,
        employeeSpecialization,
        employeePosition,
        employeeSalary,
        employeeAddress
      ];
  @override
  String get aliasedName => _alias ?? 'EmployeesTable';
  @override
  String get actualTableName => 'EmployeesTable';
  @override
  VerificationContext validateIntegrity(Insertable<EmployeesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    }
    if (data.containsKey('employee_name')) {
      context.handle(
          _employeeNameMeta,
          employeeName.isAcceptableOrUnknown(
              data['employee_name']!, _employeeNameMeta));
    } else if (isInserting) {
      context.missing(_employeeNameMeta);
    }
    if (data.containsKey('employee_phone_number')) {
      context.handle(
          _employeePhoneNumberMeta,
          employeePhoneNumber.isAcceptableOrUnknown(
              data['employee_phone_number']!, _employeePhoneNumberMeta));
    } else if (isInserting) {
      context.missing(_employeePhoneNumberMeta);
    }
    if (data.containsKey('employee_specialization')) {
      context.handle(
          _employeeSpecializationMeta,
          employeeSpecialization.isAcceptableOrUnknown(
              data['employee_specialization']!, _employeeSpecializationMeta));
    } else if (isInserting) {
      context.missing(_employeeSpecializationMeta);
    }
    if (data.containsKey('employee_position')) {
      context.handle(
          _employeePositionMeta,
          employeePosition.isAcceptableOrUnknown(
              data['employee_position']!, _employeePositionMeta));
    } else if (isInserting) {
      context.missing(_employeePositionMeta);
    }
    if (data.containsKey('employee_salary')) {
      context.handle(
          _employeeSalaryMeta,
          employeeSalary.isAcceptableOrUnknown(
              data['employee_salary']!, _employeeSalaryMeta));
    }
    if (data.containsKey('employee_address')) {
      context.handle(
          _employeeAddressMeta,
          employeeAddress.isAcceptableOrUnknown(
              data['employee_address']!, _employeeAddressMeta));
    } else if (isInserting) {
      context.missing(_employeeAddressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId};
  @override
  EmployeesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeesTableData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}employee_id'])!,
      employeeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_name'])!,
      employeePhoneNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}employee_phone_number'])!,
      employeeSpecialization: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}employee_specialization'])!,
      employeePosition: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}employee_position'])!,
      employeeSalary: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}employee_salary'])!,
      employeeAddress: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}employee_address'])!,
    );
  }

  @override
  EmployeesTable createAlias(String alias) {
    return EmployeesTable(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class EmployeesTableData extends DataClass
    implements Insertable<EmployeesTableData> {
  final int employeeId;
  final String employeeName;
  final int employeePhoneNumber;
  final String employeeSpecialization;
  final String employeePosition;
  final double employeeSalary;
  final String employeeAddress;
  const EmployeesTableData(
      {required this.employeeId,
      required this.employeeName,
      required this.employeePhoneNumber,
      required this.employeeSpecialization,
      required this.employeePosition,
      required this.employeeSalary,
      required this.employeeAddress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<int>(employeeId);
    map['employee_name'] = Variable<String>(employeeName);
    map['employee_phone_number'] = Variable<int>(employeePhoneNumber);
    map['employee_specialization'] = Variable<String>(employeeSpecialization);
    map['employee_position'] = Variable<String>(employeePosition);
    map['employee_salary'] = Variable<double>(employeeSalary);
    map['employee_address'] = Variable<String>(employeeAddress);
    return map;
  }

  EmployeesTableCompanion toCompanion(bool nullToAbsent) {
    return EmployeesTableCompanion(
      employeeId: Value(employeeId),
      employeeName: Value(employeeName),
      employeePhoneNumber: Value(employeePhoneNumber),
      employeeSpecialization: Value(employeeSpecialization),
      employeePosition: Value(employeePosition),
      employeeSalary: Value(employeeSalary),
      employeeAddress: Value(employeeAddress),
    );
  }

  factory EmployeesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeesTableData(
      employeeId: serializer.fromJson<int>(json['employee_id']),
      employeeName: serializer.fromJson<String>(json['employee_name']),
      employeePhoneNumber:
          serializer.fromJson<int>(json['employee_phone_number']),
      employeeSpecialization:
          serializer.fromJson<String>(json['employee_specialization']),
      employeePosition: serializer.fromJson<String>(json['employee_position']),
      employeeSalary: serializer.fromJson<double>(json['employee_salary']),
      employeeAddress: serializer.fromJson<String>(json['employee_address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employee_id': serializer.toJson<int>(employeeId),
      'employee_name': serializer.toJson<String>(employeeName),
      'employee_phone_number': serializer.toJson<int>(employeePhoneNumber),
      'employee_specialization':
          serializer.toJson<String>(employeeSpecialization),
      'employee_position': serializer.toJson<String>(employeePosition),
      'employee_salary': serializer.toJson<double>(employeeSalary),
      'employee_address': serializer.toJson<String>(employeeAddress),
    };
  }

  EmployeesTableData copyWith(
          {int? employeeId,
          String? employeeName,
          int? employeePhoneNumber,
          String? employeeSpecialization,
          String? employeePosition,
          double? employeeSalary,
          String? employeeAddress}) =>
      EmployeesTableData(
        employeeId: employeeId ?? this.employeeId,
        employeeName: employeeName ?? this.employeeName,
        employeePhoneNumber: employeePhoneNumber ?? this.employeePhoneNumber,
        employeeSpecialization:
            employeeSpecialization ?? this.employeeSpecialization,
        employeePosition: employeePosition ?? this.employeePosition,
        employeeSalary: employeeSalary ?? this.employeeSalary,
        employeeAddress: employeeAddress ?? this.employeeAddress,
      );
  @override
  String toString() {
    return (StringBuffer('EmployeesTableData(')
          ..write('employeeId: $employeeId, ')
          ..write('employeeName: $employeeName, ')
          ..write('employeePhoneNumber: $employeePhoneNumber, ')
          ..write('employeeSpecialization: $employeeSpecialization, ')
          ..write('employeePosition: $employeePosition, ')
          ..write('employeeSalary: $employeeSalary, ')
          ..write('employeeAddress: $employeeAddress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      employeeId,
      employeeName,
      employeePhoneNumber,
      employeeSpecialization,
      employeePosition,
      employeeSalary,
      employeeAddress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeesTableData &&
          other.employeeId == this.employeeId &&
          other.employeeName == this.employeeName &&
          other.employeePhoneNumber == this.employeePhoneNumber &&
          other.employeeSpecialization == this.employeeSpecialization &&
          other.employeePosition == this.employeePosition &&
          other.employeeSalary == this.employeeSalary &&
          other.employeeAddress == this.employeeAddress);
}

class EmployeesTableCompanion extends UpdateCompanion<EmployeesTableData> {
  final Value<int> employeeId;
  final Value<String> employeeName;
  final Value<int> employeePhoneNumber;
  final Value<String> employeeSpecialization;
  final Value<String> employeePosition;
  final Value<double> employeeSalary;
  final Value<String> employeeAddress;
  const EmployeesTableCompanion({
    this.employeeId = const Value.absent(),
    this.employeeName = const Value.absent(),
    this.employeePhoneNumber = const Value.absent(),
    this.employeeSpecialization = const Value.absent(),
    this.employeePosition = const Value.absent(),
    this.employeeSalary = const Value.absent(),
    this.employeeAddress = const Value.absent(),
  });
  EmployeesTableCompanion.insert({
    this.employeeId = const Value.absent(),
    required String employeeName,
    required int employeePhoneNumber,
    required String employeeSpecialization,
    required String employeePosition,
    this.employeeSalary = const Value.absent(),
    required String employeeAddress,
  })  : employeeName = Value(employeeName),
        employeePhoneNumber = Value(employeePhoneNumber),
        employeeSpecialization = Value(employeeSpecialization),
        employeePosition = Value(employeePosition),
        employeeAddress = Value(employeeAddress);
  static Insertable<EmployeesTableData> custom({
    Expression<int>? employeeId,
    Expression<String>? employeeName,
    Expression<int>? employeePhoneNumber,
    Expression<String>? employeeSpecialization,
    Expression<String>? employeePosition,
    Expression<double>? employeeSalary,
    Expression<String>? employeeAddress,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (employeeName != null) 'employee_name': employeeName,
      if (employeePhoneNumber != null)
        'employee_phone_number': employeePhoneNumber,
      if (employeeSpecialization != null)
        'employee_specialization': employeeSpecialization,
      if (employeePosition != null) 'employee_position': employeePosition,
      if (employeeSalary != null) 'employee_salary': employeeSalary,
      if (employeeAddress != null) 'employee_address': employeeAddress,
    });
  }

  EmployeesTableCompanion copyWith(
      {Value<int>? employeeId,
      Value<String>? employeeName,
      Value<int>? employeePhoneNumber,
      Value<String>? employeeSpecialization,
      Value<String>? employeePosition,
      Value<double>? employeeSalary,
      Value<String>? employeeAddress}) {
    return EmployeesTableCompanion(
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      employeePhoneNumber: employeePhoneNumber ?? this.employeePhoneNumber,
      employeeSpecialization:
          employeeSpecialization ?? this.employeeSpecialization,
      employeePosition: employeePosition ?? this.employeePosition,
      employeeSalary: employeeSalary ?? this.employeeSalary,
      employeeAddress: employeeAddress ?? this.employeeAddress,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<int>(employeeId.value);
    }
    if (employeeName.present) {
      map['employee_name'] = Variable<String>(employeeName.value);
    }
    if (employeePhoneNumber.present) {
      map['employee_phone_number'] = Variable<int>(employeePhoneNumber.value);
    }
    if (employeeSpecialization.present) {
      map['employee_specialization'] =
          Variable<String>(employeeSpecialization.value);
    }
    if (employeePosition.present) {
      map['employee_position'] = Variable<String>(employeePosition.value);
    }
    if (employeeSalary.present) {
      map['employee_salary'] = Variable<double>(employeeSalary.value);
    }
    if (employeeAddress.present) {
      map['employee_address'] = Variable<String>(employeeAddress.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesTableCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('employeeName: $employeeName, ')
          ..write('employeePhoneNumber: $employeePhoneNumber, ')
          ..write('employeeSpecialization: $employeeSpecialization, ')
          ..write('employeePosition: $employeePosition, ')
          ..write('employeeSalary: $employeeSalary, ')
          ..write('employeeAddress: $employeeAddress')
          ..write(')'))
        .toString();
  }
}

class TeamsDataTable extends Table
    with TableInfo<TeamsDataTable, TeamsDataTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TeamsDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
      'team_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _teamNameMeta =
      const VerificationMeta('teamName');
  late final GeneratedColumn<String> teamName = GeneratedColumn<String>(
      'team_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _teamCaptainIdMeta =
      const VerificationMeta('teamCaptainId');
  late final GeneratedColumn<int> teamCaptainId = GeneratedColumn<int>(
      'team_captain_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _teamPrivateMeta =
      const VerificationMeta('teamPrivate');
  late final GeneratedColumn<int> teamPrivate = GeneratedColumn<int>(
      'team_private', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (-1)',
      defaultValue: const CustomExpression('-1'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, teamId, teamName, teamCaptainId, teamPrivate];
  @override
  String get aliasedName => _alias ?? 'TeamsDataTable';
  @override
  String get actualTableName => 'TeamsDataTable';
  @override
  VerificationContext validateIntegrity(Insertable<TeamsDataTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('team_name')) {
      context.handle(_teamNameMeta,
          teamName.isAcceptableOrUnknown(data['team_name']!, _teamNameMeta));
    } else if (isInserting) {
      context.missing(_teamNameMeta);
    }
    if (data.containsKey('team_captain_id')) {
      context.handle(
          _teamCaptainIdMeta,
          teamCaptainId.isAcceptableOrUnknown(
              data['team_captain_id']!, _teamCaptainIdMeta));
    } else if (isInserting) {
      context.missing(_teamCaptainIdMeta);
    }
    if (data.containsKey('team_private')) {
      context.handle(
          _teamPrivateMeta,
          teamPrivate.isAcceptableOrUnknown(
              data['team_private']!, _teamPrivateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamsDataTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamsDataTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_id'])!,
      teamName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_name'])!,
      teamCaptainId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_captain_id'])!,
      teamPrivate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_private'])!,
    );
  }

  @override
  TeamsDataTable createAlias(String alias) {
    return TeamsDataTable(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(team_captain_id)REFERENCES EmployeesTable(employee_id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class TeamsDataTableData extends DataClass
    implements Insertable<TeamsDataTableData> {
  final int? id;
  final int teamId;
  final String teamName;
  final int teamCaptainId;
  final int teamPrivate;
  const TeamsDataTableData(
      {this.id,
      required this.teamId,
      required this.teamName,
      required this.teamCaptainId,
      required this.teamPrivate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['team_id'] = Variable<int>(teamId);
    map['team_name'] = Variable<String>(teamName);
    map['team_captain_id'] = Variable<int>(teamCaptainId);
    map['team_private'] = Variable<int>(teamPrivate);
    return map;
  }

  TeamsDataTableCompanion toCompanion(bool nullToAbsent) {
    return TeamsDataTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      teamId: Value(teamId),
      teamName: Value(teamName),
      teamCaptainId: Value(teamCaptainId),
      teamPrivate: Value(teamPrivate),
    );
  }

  factory TeamsDataTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamsDataTableData(
      id: serializer.fromJson<int?>(json['id']),
      teamId: serializer.fromJson<int>(json['team_id']),
      teamName: serializer.fromJson<String>(json['team_name']),
      teamCaptainId: serializer.fromJson<int>(json['team_captain_id']),
      teamPrivate: serializer.fromJson<int>(json['team_private']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'team_id': serializer.toJson<int>(teamId),
      'team_name': serializer.toJson<String>(teamName),
      'team_captain_id': serializer.toJson<int>(teamCaptainId),
      'team_private': serializer.toJson<int>(teamPrivate),
    };
  }

  TeamsDataTableData copyWith(
          {Value<int?> id = const Value.absent(),
          int? teamId,
          String? teamName,
          int? teamCaptainId,
          int? teamPrivate}) =>
      TeamsDataTableData(
        id: id.present ? id.value : this.id,
        teamId: teamId ?? this.teamId,
        teamName: teamName ?? this.teamName,
        teamCaptainId: teamCaptainId ?? this.teamCaptainId,
        teamPrivate: teamPrivate ?? this.teamPrivate,
      );
  @override
  String toString() {
    return (StringBuffer('TeamsDataTableData(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('teamName: $teamName, ')
          ..write('teamCaptainId: $teamCaptainId, ')
          ..write('teamPrivate: $teamPrivate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, teamId, teamName, teamCaptainId, teamPrivate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamsDataTableData &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.teamName == this.teamName &&
          other.teamCaptainId == this.teamCaptainId &&
          other.teamPrivate == this.teamPrivate);
}

class TeamsDataTableCompanion extends UpdateCompanion<TeamsDataTableData> {
  final Value<int?> id;
  final Value<int> teamId;
  final Value<String> teamName;
  final Value<int> teamCaptainId;
  final Value<int> teamPrivate;
  const TeamsDataTableCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.teamName = const Value.absent(),
    this.teamCaptainId = const Value.absent(),
    this.teamPrivate = const Value.absent(),
  });
  TeamsDataTableCompanion.insert({
    this.id = const Value.absent(),
    required int teamId,
    required String teamName,
    required int teamCaptainId,
    this.teamPrivate = const Value.absent(),
  })  : teamId = Value(teamId),
        teamName = Value(teamName),
        teamCaptainId = Value(teamCaptainId);
  static Insertable<TeamsDataTableData> custom({
    Expression<int>? id,
    Expression<int>? teamId,
    Expression<String>? teamName,
    Expression<int>? teamCaptainId,
    Expression<int>? teamPrivate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (teamName != null) 'team_name': teamName,
      if (teamCaptainId != null) 'team_captain_id': teamCaptainId,
      if (teamPrivate != null) 'team_private': teamPrivate,
    });
  }

  TeamsDataTableCompanion copyWith(
      {Value<int?>? id,
      Value<int>? teamId,
      Value<String>? teamName,
      Value<int>? teamCaptainId,
      Value<int>? teamPrivate}) {
    return TeamsDataTableCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      teamCaptainId: teamCaptainId ?? this.teamCaptainId,
      teamPrivate: teamPrivate ?? this.teamPrivate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (teamName.present) {
      map['team_name'] = Variable<String>(teamName.value);
    }
    if (teamCaptainId.present) {
      map['team_captain_id'] = Variable<int>(teamCaptainId.value);
    }
    if (teamPrivate.present) {
      map['team_private'] = Variable<int>(teamPrivate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsDataTableCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('teamName: $teamName, ')
          ..write('teamCaptainId: $teamCaptainId, ')
          ..write('teamPrivate: $teamPrivate')
          ..write(')'))
        .toString();
  }
}

class PlayersLogsTable extends Table
    with TableInfo<PlayersLogsTable, PlayersLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PlayersLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
      'player_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _playerIndexIdMeta =
      const VerificationMeta('playerIndexId');
  late final GeneratedColumn<int> playerIndexId = GeneratedColumn<int>(
      'player_index_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
      'team_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _playerEntranceDateMeta =
      const VerificationMeta('playerEntranceDate');
  late final GeneratedColumn<DateTime> playerEntranceDate =
      GeneratedColumn<DateTime>('player_entrance_date', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, playerId, playerIndexId, teamId, playerEntranceDate];
  @override
  String get aliasedName => _alias ?? 'PlayersLogsTable';
  @override
  String get actualTableName => 'PlayersLogsTable';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlayersLogsTableData> instance,
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
    if (data.containsKey('player_index_id')) {
      context.handle(
          _playerIndexIdMeta,
          playerIndexId.isAcceptableOrUnknown(
              data['player_index_id']!, _playerIndexIdMeta));
    } else if (isInserting) {
      context.missing(_playerIndexIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('player_entrance_date')) {
      context.handle(
          _playerEntranceDateMeta,
          playerEntranceDate.isAcceptableOrUnknown(
              data['player_entrance_date']!, _playerEntranceDateMeta));
    } else if (isInserting) {
      context.missing(_playerEntranceDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayersLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayersLogsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_id'])!,
      playerIndexId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_index_id'])!,
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_id'])!,
      playerEntranceDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}player_entrance_date'])!,
    );
  }

  @override
  PlayersLogsTable createAlias(String alias) {
    return PlayersLogsTable(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(player_id)REFERENCES Players(player_index_id)',
        'FOREIGN KEY(team_id)REFERENCES TeamsDataTable(team_id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class PlayersLogsTableData extends DataClass
    implements Insertable<PlayersLogsTableData> {
  final int id;
  final int playerId;
  final int playerIndexId;
  final int teamId;
  final DateTime playerEntranceDate;
  const PlayersLogsTableData(
      {required this.id,
      required this.playerId,
      required this.playerIndexId,
      required this.teamId,
      required this.playerEntranceDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['player_index_id'] = Variable<int>(playerIndexId);
    map['team_id'] = Variable<int>(teamId);
    map['player_entrance_date'] = Variable<DateTime>(playerEntranceDate);
    return map;
  }

  PlayersLogsTableCompanion toCompanion(bool nullToAbsent) {
    return PlayersLogsTableCompanion(
      id: Value(id),
      playerId: Value(playerId),
      playerIndexId: Value(playerIndexId),
      teamId: Value(teamId),
      playerEntranceDate: Value(playerEntranceDate),
    );
  }

  factory PlayersLogsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayersLogsTableData(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['player_id']),
      playerIndexId: serializer.fromJson<int>(json['player_index_id']),
      teamId: serializer.fromJson<int>(json['team_id']),
      playerEntranceDate:
          serializer.fromJson<DateTime>(json['player_entrance_date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'player_id': serializer.toJson<int>(playerId),
      'player_index_id': serializer.toJson<int>(playerIndexId),
      'team_id': serializer.toJson<int>(teamId),
      'player_entrance_date': serializer.toJson<DateTime>(playerEntranceDate),
    };
  }

  PlayersLogsTableData copyWith(
          {int? id,
          int? playerId,
          int? playerIndexId,
          int? teamId,
          DateTime? playerEntranceDate}) =>
      PlayersLogsTableData(
        id: id ?? this.id,
        playerId: playerId ?? this.playerId,
        playerIndexId: playerIndexId ?? this.playerIndexId,
        teamId: teamId ?? this.teamId,
        playerEntranceDate: playerEntranceDate ?? this.playerEntranceDate,
      );
  @override
  String toString() {
    return (StringBuffer('PlayersLogsTableData(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('playerIndexId: $playerIndexId, ')
          ..write('teamId: $teamId, ')
          ..write('playerEntranceDate: $playerEntranceDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, playerId, playerIndexId, teamId, playerEntranceDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayersLogsTableData &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.playerIndexId == this.playerIndexId &&
          other.teamId == this.teamId &&
          other.playerEntranceDate == this.playerEntranceDate);
}

class PlayersLogsTableCompanion extends UpdateCompanion<PlayersLogsTableData> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<int> playerIndexId;
  final Value<int> teamId;
  final Value<DateTime> playerEntranceDate;
  const PlayersLogsTableCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.playerIndexId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.playerEntranceDate = const Value.absent(),
  });
  PlayersLogsTableCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required int playerIndexId,
    required int teamId,
    required DateTime playerEntranceDate,
  })  : playerId = Value(playerId),
        playerIndexId = Value(playerIndexId),
        teamId = Value(teamId),
        playerEntranceDate = Value(playerEntranceDate);
  static Insertable<PlayersLogsTableData> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<int>? playerIndexId,
    Expression<int>? teamId,
    Expression<DateTime>? playerEntranceDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (playerIndexId != null) 'player_index_id': playerIndexId,
      if (teamId != null) 'team_id': teamId,
      if (playerEntranceDate != null)
        'player_entrance_date': playerEntranceDate,
    });
  }

  PlayersLogsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? playerId,
      Value<int>? playerIndexId,
      Value<int>? teamId,
      Value<DateTime>? playerEntranceDate}) {
    return PlayersLogsTableCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      playerIndexId: playerIndexId ?? this.playerIndexId,
      teamId: teamId ?? this.teamId,
      playerEntranceDate: playerEntranceDate ?? this.playerEntranceDate,
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
    if (playerIndexId.present) {
      map['player_index_id'] = Variable<int>(playerIndexId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (playerEntranceDate.present) {
      map['player_entrance_date'] =
          Variable<DateTime>(playerEntranceDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('playerIndexId: $playerIndexId, ')
          ..write('teamId: $teamId, ')
          ..write('playerEntranceDate: $playerEntranceDate')
          ..write(')'))
        .toString();
  }
}

class SubscriptionsInfoTable extends Table
    with TableInfo<SubscriptionsInfoTable, SubscriptionsInfoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SubscriptionsInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _subscriptionNameMeta =
      const VerificationMeta('subscriptionName');
  late final GeneratedColumn<String> subscriptionName = GeneratedColumn<String>(
      'subscription_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _subscriptionValueMeta =
      const VerificationMeta('subscriptionValue');
  late final GeneratedColumn<int> subscriptionValue = GeneratedColumn<int>(
      'subscription_value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _subscriptionDurationMeta =
      const VerificationMeta('subscriptionDuration');
  late final GeneratedColumn<int> subscriptionDuration = GeneratedColumn<int>(
      'subscription_duration', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _subscriptionFreezeLimitMeta =
      const VerificationMeta('subscriptionFreezeLimit');
  late final GeneratedColumn<int> subscriptionFreezeLimit =
      GeneratedColumn<int>('subscription_freeze_limit', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  static const VerificationMeta _subscriptionInvitationLimitMeta =
      const VerificationMeta('subscriptionInvitationLimit');
  late final GeneratedColumn<int> subscriptionInvitationLimit =
      GeneratedColumn<int>('subscription_invitation_limit', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        subscriptionName,
        subscriptionValue,
        subscriptionDuration,
        subscriptionFreezeLimit,
        subscriptionInvitationLimit
      ];
  @override
  String get aliasedName => _alias ?? 'SubscriptionsInfoTable';
  @override
  String get actualTableName => 'SubscriptionsInfoTable';
  @override
  VerificationContext validateIntegrity(
      Insertable<SubscriptionsInfoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subscription_name')) {
      context.handle(
          _subscriptionNameMeta,
          subscriptionName.isAcceptableOrUnknown(
              data['subscription_name']!, _subscriptionNameMeta));
    } else if (isInserting) {
      context.missing(_subscriptionNameMeta);
    }
    if (data.containsKey('subscription_value')) {
      context.handle(
          _subscriptionValueMeta,
          subscriptionValue.isAcceptableOrUnknown(
              data['subscription_value']!, _subscriptionValueMeta));
    } else if (isInserting) {
      context.missing(_subscriptionValueMeta);
    }
    if (data.containsKey('subscription_duration')) {
      context.handle(
          _subscriptionDurationMeta,
          subscriptionDuration.isAcceptableOrUnknown(
              data['subscription_duration']!, _subscriptionDurationMeta));
    } else if (isInserting) {
      context.missing(_subscriptionDurationMeta);
    }
    if (data.containsKey('subscription_freeze_limit')) {
      context.handle(
          _subscriptionFreezeLimitMeta,
          subscriptionFreezeLimit.isAcceptableOrUnknown(
              data['subscription_freeze_limit']!,
              _subscriptionFreezeLimitMeta));
    } else if (isInserting) {
      context.missing(_subscriptionFreezeLimitMeta);
    }
    if (data.containsKey('subscription_invitation_limit')) {
      context.handle(
          _subscriptionInvitationLimitMeta,
          subscriptionInvitationLimit.isAcceptableOrUnknown(
              data['subscription_invitation_limit']!,
              _subscriptionInvitationLimitMeta));
    } else if (isInserting) {
      context.missing(_subscriptionInvitationLimitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubscriptionsInfoTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubscriptionsInfoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      subscriptionName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}subscription_name'])!,
      subscriptionValue: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}subscription_value'])!,
      subscriptionDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}subscription_duration'])!,
      subscriptionFreezeLimit: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}subscription_freeze_limit'])!,
      subscriptionInvitationLimit: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}subscription_invitation_limit'])!,
    );
  }

  @override
  SubscriptionsInfoTable createAlias(String alias) {
    return SubscriptionsInfoTable(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class SubscriptionsInfoTableData extends DataClass
    implements Insertable<SubscriptionsInfoTableData> {
  final int? id;
  final String subscriptionName;
  final int subscriptionValue;
  final int subscriptionDuration;
  final int subscriptionFreezeLimit;
  final int subscriptionInvitationLimit;
  const SubscriptionsInfoTableData(
      {this.id,
      required this.subscriptionName,
      required this.subscriptionValue,
      required this.subscriptionDuration,
      required this.subscriptionFreezeLimit,
      required this.subscriptionInvitationLimit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['subscription_name'] = Variable<String>(subscriptionName);
    map['subscription_value'] = Variable<int>(subscriptionValue);
    map['subscription_duration'] = Variable<int>(subscriptionDuration);
    map['subscription_freeze_limit'] = Variable<int>(subscriptionFreezeLimit);
    map['subscription_invitation_limit'] =
        Variable<int>(subscriptionInvitationLimit);
    return map;
  }

  SubscriptionsInfoTableCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsInfoTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      subscriptionName: Value(subscriptionName),
      subscriptionValue: Value(subscriptionValue),
      subscriptionDuration: Value(subscriptionDuration),
      subscriptionFreezeLimit: Value(subscriptionFreezeLimit),
      subscriptionInvitationLimit: Value(subscriptionInvitationLimit),
    );
  }

  factory SubscriptionsInfoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubscriptionsInfoTableData(
      id: serializer.fromJson<int?>(json['id']),
      subscriptionName: serializer.fromJson<String>(json['subscription_name']),
      subscriptionValue: serializer.fromJson<int>(json['subscription_value']),
      subscriptionDuration:
          serializer.fromJson<int>(json['subscription_duration']),
      subscriptionFreezeLimit:
          serializer.fromJson<int>(json['subscription_freeze_limit']),
      subscriptionInvitationLimit:
          serializer.fromJson<int>(json['subscription_invitation_limit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'subscription_name': serializer.toJson<String>(subscriptionName),
      'subscription_value': serializer.toJson<int>(subscriptionValue),
      'subscription_duration': serializer.toJson<int>(subscriptionDuration),
      'subscription_freeze_limit':
          serializer.toJson<int>(subscriptionFreezeLimit),
      'subscription_invitation_limit':
          serializer.toJson<int>(subscriptionInvitationLimit),
    };
  }

  SubscriptionsInfoTableData copyWith(
          {Value<int?> id = const Value.absent(),
          String? subscriptionName,
          int? subscriptionValue,
          int? subscriptionDuration,
          int? subscriptionFreezeLimit,
          int? subscriptionInvitationLimit}) =>
      SubscriptionsInfoTableData(
        id: id.present ? id.value : this.id,
        subscriptionName: subscriptionName ?? this.subscriptionName,
        subscriptionValue: subscriptionValue ?? this.subscriptionValue,
        subscriptionDuration: subscriptionDuration ?? this.subscriptionDuration,
        subscriptionFreezeLimit:
            subscriptionFreezeLimit ?? this.subscriptionFreezeLimit,
        subscriptionInvitationLimit:
            subscriptionInvitationLimit ?? this.subscriptionInvitationLimit,
      );
  @override
  String toString() {
    return (StringBuffer('SubscriptionsInfoTableData(')
          ..write('id: $id, ')
          ..write('subscriptionName: $subscriptionName, ')
          ..write('subscriptionValue: $subscriptionValue, ')
          ..write('subscriptionDuration: $subscriptionDuration, ')
          ..write('subscriptionFreezeLimit: $subscriptionFreezeLimit, ')
          ..write('subscriptionInvitationLimit: $subscriptionInvitationLimit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      subscriptionName,
      subscriptionValue,
      subscriptionDuration,
      subscriptionFreezeLimit,
      subscriptionInvitationLimit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubscriptionsInfoTableData &&
          other.id == this.id &&
          other.subscriptionName == this.subscriptionName &&
          other.subscriptionValue == this.subscriptionValue &&
          other.subscriptionDuration == this.subscriptionDuration &&
          other.subscriptionFreezeLimit == this.subscriptionFreezeLimit &&
          other.subscriptionInvitationLimit ==
              this.subscriptionInvitationLimit);
}

class SubscriptionsInfoTableCompanion
    extends UpdateCompanion<SubscriptionsInfoTableData> {
  final Value<int?> id;
  final Value<String> subscriptionName;
  final Value<int> subscriptionValue;
  final Value<int> subscriptionDuration;
  final Value<int> subscriptionFreezeLimit;
  final Value<int> subscriptionInvitationLimit;
  const SubscriptionsInfoTableCompanion({
    this.id = const Value.absent(),
    this.subscriptionName = const Value.absent(),
    this.subscriptionValue = const Value.absent(),
    this.subscriptionDuration = const Value.absent(),
    this.subscriptionFreezeLimit = const Value.absent(),
    this.subscriptionInvitationLimit = const Value.absent(),
  });
  SubscriptionsInfoTableCompanion.insert({
    this.id = const Value.absent(),
    required String subscriptionName,
    required int subscriptionValue,
    required int subscriptionDuration,
    required int subscriptionFreezeLimit,
    required int subscriptionInvitationLimit,
  })  : subscriptionName = Value(subscriptionName),
        subscriptionValue = Value(subscriptionValue),
        subscriptionDuration = Value(subscriptionDuration),
        subscriptionFreezeLimit = Value(subscriptionFreezeLimit),
        subscriptionInvitationLimit = Value(subscriptionInvitationLimit);
  static Insertable<SubscriptionsInfoTableData> custom({
    Expression<int>? id,
    Expression<String>? subscriptionName,
    Expression<int>? subscriptionValue,
    Expression<int>? subscriptionDuration,
    Expression<int>? subscriptionFreezeLimit,
    Expression<int>? subscriptionInvitationLimit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subscriptionName != null) 'subscription_name': subscriptionName,
      if (subscriptionValue != null) 'subscription_value': subscriptionValue,
      if (subscriptionDuration != null)
        'subscription_duration': subscriptionDuration,
      if (subscriptionFreezeLimit != null)
        'subscription_freeze_limit': subscriptionFreezeLimit,
      if (subscriptionInvitationLimit != null)
        'subscription_invitation_limit': subscriptionInvitationLimit,
    });
  }

  SubscriptionsInfoTableCompanion copyWith(
      {Value<int?>? id,
      Value<String>? subscriptionName,
      Value<int>? subscriptionValue,
      Value<int>? subscriptionDuration,
      Value<int>? subscriptionFreezeLimit,
      Value<int>? subscriptionInvitationLimit}) {
    return SubscriptionsInfoTableCompanion(
      id: id ?? this.id,
      subscriptionName: subscriptionName ?? this.subscriptionName,
      subscriptionValue: subscriptionValue ?? this.subscriptionValue,
      subscriptionDuration: subscriptionDuration ?? this.subscriptionDuration,
      subscriptionFreezeLimit:
          subscriptionFreezeLimit ?? this.subscriptionFreezeLimit,
      subscriptionInvitationLimit:
          subscriptionInvitationLimit ?? this.subscriptionInvitationLimit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subscriptionName.present) {
      map['subscription_name'] = Variable<String>(subscriptionName.value);
    }
    if (subscriptionValue.present) {
      map['subscription_value'] = Variable<int>(subscriptionValue.value);
    }
    if (subscriptionDuration.present) {
      map['subscription_duration'] = Variable<int>(subscriptionDuration.value);
    }
    if (subscriptionFreezeLimit.present) {
      map['subscription_freeze_limit'] =
          Variable<int>(subscriptionFreezeLimit.value);
    }
    if (subscriptionInvitationLimit.present) {
      map['subscription_invitation_limit'] =
          Variable<int>(subscriptionInvitationLimit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsInfoTableCompanion(')
          ..write('id: $id, ')
          ..write('subscriptionName: $subscriptionName, ')
          ..write('subscriptionValue: $subscriptionValue, ')
          ..write('subscriptionDuration: $subscriptionDuration, ')
          ..write('subscriptionFreezeLimit: $subscriptionFreezeLimit, ')
          ..write('subscriptionInvitationLimit: $subscriptionInvitationLimit')
          ..write(')'))
        .toString();
  }
}

class PlayersAndTeamsTable extends Table
    with TableInfo<PlayersAndTeamsTable, PlayersAndTeamsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PlayersAndTeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
      'team_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _teamPlayerIdMeta =
      const VerificationMeta('teamPlayerId');
  late final GeneratedColumn<int> teamPlayerId = GeneratedColumn<int>(
      'team_player_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, teamId, teamPlayerId];
  @override
  String get aliasedName => _alias ?? 'PlayersAndTeamsTable';
  @override
  String get actualTableName => 'PlayersAndTeamsTable';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlayersAndTeamsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('team_player_id')) {
      context.handle(
          _teamPlayerIdMeta,
          teamPlayerId.isAcceptableOrUnknown(
              data['team_player_id']!, _teamPlayerIdMeta));
    } else if (isInserting) {
      context.missing(_teamPlayerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayersAndTeamsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayersAndTeamsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_id'])!,
      teamPlayerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_player_id'])!,
    );
  }

  @override
  PlayersAndTeamsTable createAlias(String alias) {
    return PlayersAndTeamsTable(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(team_player_id)REFERENCES Players(player_index_id)',
        'FOREIGN KEY(team_id)REFERENCES TeamsDataTable(team_id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class PlayersAndTeamsTableData extends DataClass
    implements Insertable<PlayersAndTeamsTableData> {
  final int? id;
  final int teamId;
  final int teamPlayerId;
  const PlayersAndTeamsTableData(
      {this.id, required this.teamId, required this.teamPlayerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['team_id'] = Variable<int>(teamId);
    map['team_player_id'] = Variable<int>(teamPlayerId);
    return map;
  }

  PlayersAndTeamsTableCompanion toCompanion(bool nullToAbsent) {
    return PlayersAndTeamsTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      teamId: Value(teamId),
      teamPlayerId: Value(teamPlayerId),
    );
  }

  factory PlayersAndTeamsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayersAndTeamsTableData(
      id: serializer.fromJson<int?>(json['id']),
      teamId: serializer.fromJson<int>(json['team_id']),
      teamPlayerId: serializer.fromJson<int>(json['team_player_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'team_id': serializer.toJson<int>(teamId),
      'team_player_id': serializer.toJson<int>(teamPlayerId),
    };
  }

  PlayersAndTeamsTableData copyWith(
          {Value<int?> id = const Value.absent(),
          int? teamId,
          int? teamPlayerId}) =>
      PlayersAndTeamsTableData(
        id: id.present ? id.value : this.id,
        teamId: teamId ?? this.teamId,
        teamPlayerId: teamPlayerId ?? this.teamPlayerId,
      );
  @override
  String toString() {
    return (StringBuffer('PlayersAndTeamsTableData(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('teamPlayerId: $teamPlayerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, teamId, teamPlayerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayersAndTeamsTableData &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.teamPlayerId == this.teamPlayerId);
}

class PlayersAndTeamsTableCompanion
    extends UpdateCompanion<PlayersAndTeamsTableData> {
  final Value<int?> id;
  final Value<int> teamId;
  final Value<int> teamPlayerId;
  const PlayersAndTeamsTableCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.teamPlayerId = const Value.absent(),
  });
  PlayersAndTeamsTableCompanion.insert({
    this.id = const Value.absent(),
    required int teamId,
    required int teamPlayerId,
  })  : teamId = Value(teamId),
        teamPlayerId = Value(teamPlayerId);
  static Insertable<PlayersAndTeamsTableData> custom({
    Expression<int>? id,
    Expression<int>? teamId,
    Expression<int>? teamPlayerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (teamPlayerId != null) 'team_player_id': teamPlayerId,
    });
  }

  PlayersAndTeamsTableCompanion copyWith(
      {Value<int?>? id, Value<int>? teamId, Value<int>? teamPlayerId}) {
    return PlayersAndTeamsTableCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      teamPlayerId: teamPlayerId ?? this.teamPlayerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (teamPlayerId.present) {
      map['team_player_id'] = Variable<int>(teamPlayerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersAndTeamsTableCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('teamPlayerId: $teamPlayerId')
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
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
      'team_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _subscriptionPayDateMeta =
      const VerificationMeta('subscriptionPayDate');
  late final GeneratedColumn<DateTime> subscriptionPayDate =
      GeneratedColumn<DateTime>('subscription_pay_date', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
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
        teamId,
        subscriptionPayDate,
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
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('subscription_pay_date')) {
      context.handle(
          _subscriptionPayDateMeta,
          subscriptionPayDate.isAcceptableOrUnknown(
              data['subscription_pay_date']!, _subscriptionPayDateMeta));
    } else if (isInserting) {
      context.missing(_subscriptionPayDateMeta);
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
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_id'])!,
      subscriptionPayDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}subscription_pay_date'])!,
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
  final int teamId;
  final DateTime subscriptionPayDate;
  final int playerSubscriptionId;
  final DateTime beginningDate;
  final DateTime endDate;
  final int billId;
  final int billValue;
  final int duration;
  final String billCollector;
  const PlayersSubscription(
      {this.subId,
      required this.teamId,
      required this.subscriptionPayDate,
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
    map['team_id'] = Variable<int>(teamId);
    map['subscription_pay_date'] = Variable<DateTime>(subscriptionPayDate);
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
      teamId: Value(teamId),
      subscriptionPayDate: Value(subscriptionPayDate),
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
      teamId: serializer.fromJson<int>(json['team_id']),
      subscriptionPayDate:
          serializer.fromJson<DateTime>(json['subscription_pay_date']),
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
      'team_id': serializer.toJson<int>(teamId),
      'subscription_pay_date': serializer.toJson<DateTime>(subscriptionPayDate),
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
          int? teamId,
          DateTime? subscriptionPayDate,
          int? playerSubscriptionId,
          DateTime? beginningDate,
          DateTime? endDate,
          int? billId,
          int? billValue,
          int? duration,
          String? billCollector}) =>
      PlayersSubscription(
        subId: subId.present ? subId.value : this.subId,
        teamId: teamId ?? this.teamId,
        subscriptionPayDate: subscriptionPayDate ?? this.subscriptionPayDate,
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
          ..write('teamId: $teamId, ')
          ..write('subscriptionPayDate: $subscriptionPayDate, ')
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
  int get hashCode => Object.hash(
      subId,
      teamId,
      subscriptionPayDate,
      playerSubscriptionId,
      beginningDate,
      endDate,
      billId,
      billValue,
      duration,
      billCollector);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayersSubscription &&
          other.subId == this.subId &&
          other.teamId == this.teamId &&
          other.subscriptionPayDate == this.subscriptionPayDate &&
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
  final Value<int> teamId;
  final Value<DateTime> subscriptionPayDate;
  final Value<int> playerSubscriptionId;
  final Value<DateTime> beginningDate;
  final Value<DateTime> endDate;
  final Value<int> billId;
  final Value<int> billValue;
  final Value<int> duration;
  final Value<String> billCollector;
  const PlayersSubscriptionsCompanion({
    this.subId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.subscriptionPayDate = const Value.absent(),
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
    required int teamId,
    required DateTime subscriptionPayDate,
    required int playerSubscriptionId,
    required DateTime beginningDate,
    required DateTime endDate,
    required int billId,
    required int billValue,
    required int duration,
    required String billCollector,
  })  : teamId = Value(teamId),
        subscriptionPayDate = Value(subscriptionPayDate),
        playerSubscriptionId = Value(playerSubscriptionId),
        beginningDate = Value(beginningDate),
        endDate = Value(endDate),
        billId = Value(billId),
        billValue = Value(billValue),
        duration = Value(duration),
        billCollector = Value(billCollector);
  static Insertable<PlayersSubscription> custom({
    Expression<int>? subId,
    Expression<int>? teamId,
    Expression<DateTime>? subscriptionPayDate,
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
      if (teamId != null) 'team_id': teamId,
      if (subscriptionPayDate != null)
        'subscription_pay_date': subscriptionPayDate,
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
      Value<int>? teamId,
      Value<DateTime>? subscriptionPayDate,
      Value<int>? playerSubscriptionId,
      Value<DateTime>? beginningDate,
      Value<DateTime>? endDate,
      Value<int>? billId,
      Value<int>? billValue,
      Value<int>? duration,
      Value<String>? billCollector}) {
    return PlayersSubscriptionsCompanion(
      subId: subId ?? this.subId,
      teamId: teamId ?? this.teamId,
      subscriptionPayDate: subscriptionPayDate ?? this.subscriptionPayDate,
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
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (subscriptionPayDate.present) {
      map['subscription_pay_date'] =
          Variable<DateTime>(subscriptionPayDate.value);
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
          ..write('teamId: $teamId, ')
          ..write('subscriptionPayDate: $subscriptionPayDate, ')
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

abstract class _$SystemDatabase extends GeneratedDatabase {
  _$SystemDatabase(QueryExecutor e) : super(e);
  late final Players players = Players(this);
  late final EmployeesTable employeesTable = EmployeesTable(this);
  late final TeamsDataTable teamsDataTable = TeamsDataTable(this);
  late final PlayersLogsTable playersLogsTable = PlayersLogsTable(this);
  late final Index loginTimeInx = Index('login_time_inx',
      'CREATE INDEX login_time_inx ON PlayersLogsTable (player_entrance_date)');
  late final SubscriptionsInfoTable subscriptionsInfoTable =
      SubscriptionsInfoTable(this);
  late final PlayersAndTeamsTable playersAndTeamsTable =
      PlayersAndTeamsTable(this);
  late final PlayersSubscriptions playersSubscriptions =
      PlayersSubscriptions(this);
  Selectable<GetTodayLogsResult> getTodayLogs(
      DateTime dateTime, DateTime endDateTime, int teamId) {
    return customSelect(
        'SELECT DISTINCT Players.player_name, Players.player_id, Players.player_index_id, Players.image_path, PlayersLogsTable.player_entrance_date FROM Players INNER JOIN PlayersLogsTable ON PlayersLogsTable.player_index_id = Players.player_index_id WHERE PlayersLogsTable.player_entrance_date BETWEEN ?1 AND ?2 AND PlayersLogsTable.team_id = ?3',
        variables: [
          Variable<DateTime>(dateTime),
          Variable<DateTime>(endDateTime),
          Variable<int>(teamId)
        ],
        readsFrom: {
          players,
          playersLogsTable,
        }).map((QueryRow row) => GetTodayLogsResult(
          playerName: row.read<String>('player_name'),
          playerId: row.read<int>('player_id'),
          playerIndexId: row.read<int>('player_index_id'),
          imagePath: row.read<String>('image_path'),
          playerEntranceDate: row.read<DateTime>('player_entrance_date'),
        ));
  }

  Selectable<DateTime> getTodayPlayerLogs(
      int playerIndexId, int teamId, DateTime begDate, DateTime endDate) {
    return customSelect(
        'SELECT PlayersLogsTable.player_entrance_date FROM PlayersLogsTable WHERE PlayersLogsTable.player_index_id = ?1 AND PlayersLogsTable.team_id = ?2 AND PlayersLogsTable.player_entrance_date BETWEEN ?3 AND ?4 ORDER BY PlayersLogsTable.player_entrance_date ASC',
        variables: [
          Variable<int>(playerIndexId),
          Variable<int>(teamId),
          Variable<DateTime>(begDate),
          Variable<DateTime>(endDate)
        ],
        readsFrom: {
          playersLogsTable,
        }).map((QueryRow row) => row.read<DateTime>('player_entrance_date'));
  }

  Selectable<Player> allPlayers() {
    return customSelect('SELECT * FROM Players', variables: [], readsFrom: {
      players,
    }).asyncMap(players.mapFromRow);
  }

  Selectable<GetAllNamesResult> getAllNames() {
    return customSelect(
        'SELECT player_id, player_index_id, player_name FROM Players ORDER BY player_id ASC',
        variables: [],
        readsFrom: {
          players,
        }).map((QueryRow row) => GetAllNamesResult(
          playerId: row.read<int>('player_id'),
          playerIndexId: row.read<int>('player_index_id'),
          playerName: row.read<String>('player_name'),
        ));
  }

  Selectable<PlayersSubscription> allSubscriptions() {
    return customSelect('SELECT * FROM PlayersSubscriptions',
        variables: [],
        readsFrom: {
          playersSubscriptions,
        }).asyncMap(playersSubscriptions.mapFromRow);
  }

  Selectable<GetPlayerSubscriptionResult> getPlayerSubscription(
      int playerIndexId) {
    return customSelect(
        'SELECT DISTINCT Players.*, PlayersSubscriptions.* FROM Players INNER JOIN PlayersSubscriptions ON PlayersSubscriptions.player_subscription_id = ?1 INNER JOIN PlayersAndTeamsTable ON PlayersAndTeamsTable.team_player_id = ?1 WHERE Players.player_index_id = ?1 ORDER BY end_date DESC',
        variables: [
          Variable<int>(playerIndexId)
        ],
        readsFrom: {
          players,
          playersSubscriptions,
          playersAndTeamsTable,
        }).map((QueryRow row) => GetPlayerSubscriptionResult(
          id: row.read<int>('id'),
          playerIndexId: row.read<int>('player_index_id'),
          playerId: row.read<int>('player_id'),
          playerName: row.read<String>('player_name'),
          playerPhoneNumber: row.read<int>('player_phone_number'),
          imagePath: row.read<String>('image_path'),
          playerAge: row.read<int>('player_age'),
          playerFirstJoinDate: row.read<DateTime>('player_first_join_date'),
          playerGender: row.read<String>('player_gender'),
          subscriptionId: row.read<int>('subscription_id'),
          subId: row.readNullable<int>('sub_id'),
          teamId: row.read<int>('team_id'),
          subscriptionPayDate: row.read<DateTime>('subscription_pay_date'),
          playerSubscriptionId: row.read<int>('player_subscription_id'),
          beginningDate: row.read<DateTime>('beginning_date'),
          endDate: row.read<DateTime>('end_date'),
          billId: row.read<int>('billId'),
          billValue: row.read<int>('billValue'),
          duration: row.read<int>('duration'),
          billCollector: row.read<String>('billCollector'),
        ));
  }

  Selectable<TeamsDataTableData> getPlayerTeam(int playerIndexId) {
    return customSelect(
        'SELECT DISTINCT TeamsDataTable.* FROM Players INNER JOIN PlayersSubscriptions ON PlayersSubscriptions.player_subscription_id = ?1 INNER JOIN PlayersAndTeamsTable ON PlayersAndTeamsTable.team_player_id = ?1 INNER JOIN TeamsDataTable ON TeamsDataTable.team_id = PlayersAndTeamsTable.team_id WHERE Players.player_index_id = ?1',
        variables: [
          Variable<int>(playerIndexId)
        ],
        readsFrom: {
          players,
          playersSubscriptions,
          playersAndTeamsTable,
          teamsDataTable,
        }).asyncMap(teamsDataTable.mapFromRow);
  }

  Selectable<GetPlayersByTeamResult> getPlayersByTeam(int teamId) {
    return customSelect(
        'SELECT DISTINCT player_id, player_index_id, player_name FROM Players INNER JOIN PlayersAndTeamsTable ON PlayersAndTeamsTable.team_player_id = Players.player_index_id INNER JOIN PlayersSubscriptions ON PlayersSubscriptions.player_subscription_id = Players.player_index_id WHERE PlayersAndTeamsTable.team_id = ?1 ORDER BY Players.player_first_join_date DESC',
        variables: [
          Variable<int>(teamId)
        ],
        readsFrom: {
          players,
          playersAndTeamsTable,
          playersSubscriptions,
        }).map((QueryRow row) => GetPlayersByTeamResult(
          playerId: row.read<int>('player_id'),
          playerIndexId: row.read<int>('player_index_id'),
          playerName: row.read<String>('player_name'),
        ));
  }

  Selectable<GetEndedSubscriptionByTeamResult> getEndedSubscriptionByTeam(
      DateTime beginDateTime, DateTime secondDateTime, int teamId) {
    return customSelect(
        'SELECT Players.*, PlayersSubscriptions.* FROM Players LEFT JOIN PlayersAndTeamsTable ON PlayersAndTeamsTable.team_player_id = Players.player_index_id INNER JOIN (SELECT PlayersSubscriptions.player_subscription_id, MAX(PlayersSubscriptions.beginning_date) AS _c0, MAX(PlayersSubscriptions.end_date) AS latest_end_date FROM PlayersSubscriptions WHERE end_date BETWEEN ?1 AND ?2 AND PlayersSubscriptions.beginning_date < ?2 GROUP BY player_subscription_id) AS LatestSubscriptions ON Players.player_index_id = LatestSubscriptions.player_subscription_id LEFT JOIN PlayersSubscriptions ON PlayersSubscriptions.player_subscription_id = Players.player_index_id WHERE PlayersAndTeamsTable.team_id = ?3 AND PlayersSubscriptions.team_id = ?3 AND PlayersSubscriptions.end_date = LatestSubscriptions.latest_end_date AND PlayersSubscriptions.beginning_date < ?2 ORDER BY PlayersSubscriptions.end_date DESC',
        variables: [
          Variable<DateTime>(beginDateTime),
          Variable<DateTime>(secondDateTime),
          Variable<int>(teamId)
        ],
        readsFrom: {
          players,
          playersAndTeamsTable,
          playersSubscriptions,
        }).map((QueryRow row) => GetEndedSubscriptionByTeamResult(
          id: row.read<int>('id'),
          playerIndexId: row.read<int>('player_index_id'),
          playerId: row.read<int>('player_id'),
          playerName: row.read<String>('player_name'),
          playerPhoneNumber: row.read<int>('player_phone_number'),
          imagePath: row.read<String>('image_path'),
          playerAge: row.read<int>('player_age'),
          playerFirstJoinDate: row.read<DateTime>('player_first_join_date'),
          playerGender: row.read<String>('player_gender'),
          subscriptionId: row.read<int>('subscription_id'),
          subId: row.readNullable<int>('sub_id'),
          teamId: row.readNullable<int>('team_id'),
          subscriptionPayDate:
              row.readNullable<DateTime>('subscription_pay_date'),
          playerSubscriptionId: row.readNullable<int>('player_subscription_id'),
          beginningDate: row.readNullable<DateTime>('beginning_date'),
          endDate: row.readNullable<DateTime>('end_date'),
          billId: row.readNullable<int>('billId'),
          billValue: row.readNullable<int>('billValue'),
          duration: row.readNullable<int>('duration'),
          billCollector: row.readNullable<String>('billCollector'),
        ));
  }

  Selectable<Player> filterNewPlayers(
      DateTime? beginDate, DateTime? endDate, int? billVal, int? teamId) {
    return customSelect(
        'SELECT DISTINCT Players.* FROM PLAYERS INNER JOIN PlayersSubscriptions ON Players.player_index_id = PlayersSubscriptions.player_subscription_id INNER JOIN PlayersAndTeamsTable ON PlayersAndTeamsTable.team_player_id = Players.player_index_id WHERE Players.player_first_join_date BETWEEN ?1 AND ?2 AND(PlayersSubscriptions.billValue = COALESCE(?3, PlayersSubscriptions.billValue) OR ?3 IS NULL)AND(PlayersAndTeamsTable.team_id = COALESCE(?4, PlayersAndTeamsTable.team_id) OR ?4 IS NULL)ORDER BY PLAYERS.player_first_join_date DESC',
        variables: [
          Variable<DateTime>(beginDate),
          Variable<DateTime>(endDate),
          Variable<int>(billVal),
          Variable<int>(teamId)
        ],
        readsFrom: {
          players,
          playersSubscriptions,
          playersAndTeamsTable,
        }).asyncMap(players.mapFromRow);
  }

  Selectable<Player> filterEndedSubPlayers(
      DateTime? beginDate, DateTime? endDate, int? billVal, int? teamId) {
    return customSelect(
        'SELECT DISTINCT Players.* FROM PLAYERS INNER JOIN PlayersSubscriptions ON Players.player_index_id = PlayersSubscriptions.player_subscription_id INNER JOIN PlayersAndTeamsTable ON PlayersAndTeamsTable.team_player_id = Players.player_index_id WHERE PlayersSubscriptions.end_date BETWEEN ?1 AND ?2 AND(PlayersSubscriptions.billValue = COALESCE(?3, PlayersSubscriptions.billValue) OR ?3 IS NULL)AND(PlayersAndTeamsTable.team_id = COALESCE(?4, PlayersAndTeamsTable.team_id) OR ?4 IS NULL)ORDER BY PLAYERS.player_first_join_date DESC',
        variables: [
          Variable<DateTime>(beginDate),
          Variable<DateTime>(endDate),
          Variable<int>(billVal),
          Variable<int>(teamId)
        ],
        readsFrom: {
          players,
          playersSubscriptions,
          playersAndTeamsTable,
        }).asyncMap(players.mapFromRow);
  }

  Selectable<EnterPlayerToGymResult> enterPlayerToGym(
      int? playerId, String? playerName, int teamId) {
    return customSelect(
        'SELECT DISTINCT Players.player_id, Players.player_index_id, Players.player_name, PlayersSubscriptions.player_subscription_id, PlayersSubscriptions.end_date, MAX(PlayersSubscriptions.end_date) AS _c0, PlayersAndTeamsTable.team_player_id, PlayersAndTeamsTable.team_id FROM Players LEFT JOIN PlayersSubscriptions ON Players.player_index_id = PlayersSubscriptions.player_subscription_id LEFT JOIN PlayersAndTeamsTable ON Players.player_index_id = PlayersAndTeamsTable.team_player_id WHERE(Players.player_id = COALESCE(?1, Players.player_id) OR ?1 IS NULL)AND(Players.player_name = COALESCE(?2, Players.player_name) OR ?2 IS NULL)AND PlayersAndTeamsTable.team_id = ?3',
        variables: [
          Variable<int>(playerId),
          Variable<String>(playerName),
          Variable<int>(teamId)
        ],
        readsFrom: {
          players,
          playersSubscriptions,
          playersAndTeamsTable,
        }).map((QueryRow row) => EnterPlayerToGymResult(
          playerId: row.read<int>('player_id'),
          playerIndexId: row.read<int>('player_index_id'),
          playerName: row.read<String>('player_name'),
          playerSubscriptionId: row.readNullable<int>('player_subscription_id'),
          endDate: row.readNullable<DateTime>('end_date'),
          mAXPlayersSubscriptionsendDate: row.readNullable<DateTime>('_c0'),
          teamPlayerId: row.readNullable<int>('team_player_id'),
          teamId: row.readNullable<int>('team_id'),
        ));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        players,
        employeesTable,
        teamsDataTable,
        playersLogsTable,
        loginTimeInx,
        subscriptionsInfoTable,
        playersAndTeamsTable,
        playersSubscriptions
      ];
}

class GetTodayLogsResult {
  final String playerName;
  final int playerId;
  final int playerIndexId;
  final String imagePath;
  final DateTime playerEntranceDate;
  GetTodayLogsResult({
    required this.playerName,
    required this.playerId,
    required this.playerIndexId,
    required this.imagePath,
    required this.playerEntranceDate,
  });
}

class GetAllNamesResult {
  final int playerId;
  final int playerIndexId;
  final String playerName;
  GetAllNamesResult({
    required this.playerId,
    required this.playerIndexId,
    required this.playerName,
  });
}

class GetPlayerSubscriptionResult {
  final int id;
  final int playerIndexId;
  final int playerId;
  final String playerName;
  final int playerPhoneNumber;
  final String imagePath;
  final int playerAge;
  final DateTime playerFirstJoinDate;
  final String playerGender;
  final int subscriptionId;
  final int? subId;
  final int teamId;
  final DateTime subscriptionPayDate;
  final int playerSubscriptionId;
  final DateTime beginningDate;
  final DateTime endDate;
  final int billId;
  final int billValue;
  final int duration;
  final String billCollector;
  GetPlayerSubscriptionResult({
    required this.id,
    required this.playerIndexId,
    required this.playerId,
    required this.playerName,
    required this.playerPhoneNumber,
    required this.imagePath,
    required this.playerAge,
    required this.playerFirstJoinDate,
    required this.playerGender,
    required this.subscriptionId,
    this.subId,
    required this.teamId,
    required this.subscriptionPayDate,
    required this.playerSubscriptionId,
    required this.beginningDate,
    required this.endDate,
    required this.billId,
    required this.billValue,
    required this.duration,
    required this.billCollector,
  });
}

class GetPlayersByTeamResult {
  final int playerId;
  final int playerIndexId;
  final String playerName;
  GetPlayersByTeamResult({
    required this.playerId,
    required this.playerIndexId,
    required this.playerName,
  });
}

class GetEndedSubscriptionByTeamResult {
  final int id;
  final int playerIndexId;
  final int playerId;
  final String playerName;
  final int playerPhoneNumber;
  final String imagePath;
  final int playerAge;
  final DateTime playerFirstJoinDate;
  final String playerGender;
  final int subscriptionId;
  final int? subId;
  final int? teamId;
  final DateTime? subscriptionPayDate;
  final int? playerSubscriptionId;
  final DateTime? beginningDate;
  final DateTime? endDate;
  final int? billId;
  final int? billValue;
  final int? duration;
  final String? billCollector;
  GetEndedSubscriptionByTeamResult({
    required this.id,
    required this.playerIndexId,
    required this.playerId,
    required this.playerName,
    required this.playerPhoneNumber,
    required this.imagePath,
    required this.playerAge,
    required this.playerFirstJoinDate,
    required this.playerGender,
    required this.subscriptionId,
    this.subId,
    this.teamId,
    this.subscriptionPayDate,
    this.playerSubscriptionId,
    this.beginningDate,
    this.endDate,
    this.billId,
    this.billValue,
    this.duration,
    this.billCollector,
  });
}

class EnterPlayerToGymResult {
  final int playerId;
  final int playerIndexId;
  final String playerName;
  final int? playerSubscriptionId;
  final DateTime? endDate;
  final DateTime? mAXPlayersSubscriptionsendDate;
  final int? teamPlayerId;
  final int? teamId;
  EnterPlayerToGymResult({
    required this.playerId,
    required this.playerIndexId,
    required this.playerName,
    this.playerSubscriptionId,
    this.endDate,
    this.mAXPlayersSubscriptionsendDate,
    this.teamPlayerId,
    this.teamId,
  });
}
