import '../tables/generate_table.dart';

class PlayerProfileData {
  final Player profileData;
  final List<PlayersSubscription> subData;

  PlayerProfileData(this.profileData, this.subData);


}

class SubscriptionsModel {
  final int id;
  final String beginningDate;
  final String endDate;
  final int billid;
  final int billValue;
  final int duration;
  final int team;
  final String collector;
  SubscriptionsModel(
      {
        required this.team,
        required this.id,
        required this.beginningDate,
        required this.endDate,
        required this.billid,
        required this.billValue,
        required this.duration,
        required this.collector});

  factory SubscriptionsModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionsModel(
        id: json["player_subscription_id"],
        beginningDate: json["beginning_date"],
        endDate: json["end_date"],
        billid: json["billid"],
        billValue: json['billvalue'],
        duration: json["duration"],
        team: json['team'],
        collector: json['billcollector']);
  }


}

class PlayerFromBackupDB {
  final int playerId;
  final String playerName;
  final int playerPhoneNumber;
  final String imagePath;
  final int playerAge;
  final String playerFirstJoinDate;
  final String playerGender;
  final int subscriptionId;
  final int playerIndexId;

  PlayerFromBackupDB(
      {required this.playerId,
        required this.playerName,
        required this.playerPhoneNumber,
        required this.imagePath,
        required this.playerAge,
        required this.playerFirstJoinDate,
        required this.playerGender,
        required this.subscriptionId,
        required this.playerIndexId});

  factory PlayerFromBackupDB.fromJson(Map<String, dynamic> json) {
    return PlayerFromBackupDB(
        playerId: json['player_id'],
        playerName: json['player_name'],
        playerPhoneNumber: json['player_phone_number'],
        imagePath: json['image_path'],
        playerAge: json['player_age'],
        playerFirstJoinDate: json['player_first_join_date'],
        playerGender: json['player_gender'],
        subscriptionId: json['subscription_id'], playerIndexId: json['player_index_id']);
  }
}

class TeamsFromDB {
  int? id;
  int? teamId;
  String? teamName;
  int? teamCaptainId;

  TeamsFromDB({this.id, this.teamId, this.teamName, this.teamCaptainId});

  TeamsFromDB.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    teamCaptainId = json['team_captain_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['team_name'] = teamName;
    data['team_captain_id'] = teamCaptainId;
    return data;
  }


}


class EmployeesData {
  int? id;
  int? employeeId;
  String? employeeName;
  int? employeePhoneNumber;
  String? employeeSpecialization;
  String? employeePosition;
  double? employeeSalary;
  String? employeeAddress;

  EmployeesData(
      {this.id,
        this.employeeId,
        this.employeeName,
        this.employeePhoneNumber,
        this.employeeSpecialization,
        this.employeePosition,
        this.employeeSalary,
        this.employeeAddress});

  EmployeesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    employeePhoneNumber = json['employee_phone_number'];
    employeeSpecialization = json['employee_specialization'];
    employeePosition = json['employee_position'];
    employeeSalary = json['employee_salary'];
    employeeAddress = json['employee_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['employee_name'] = employeeName;
    data['employee_phone_number'] = employeePhoneNumber;
    data['employee_specialization'] = employeeSpecialization;
    data['employee_position'] = employeePosition;
    data['employee_salary'] = employeeSalary;
    data['employee_address'] = employeeAddress;
    return data;
  }
}

class PlayerTeamFromDB {
  int? id;
  int? teamId;
  int? teamPlayerId;

  PlayerTeamFromDB({this.id, this.teamId, this.teamPlayerId});

  PlayerTeamFromDB.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    teamPlayerId = json['team_player_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['team_player_id'] = teamPlayerId;
    return data;
  }
}



class DataFromDB {
  final List<PlayerFromBackupDB> players;
  final List<SubscriptionsModel> subscriptions;
  final List<TeamsFromDB> teams;
  final List<EmployeesData> employees;
  final List<PlayerTeamFromDB> playersTeam;
  DataFromDB({required this.players, required this.subscriptions ,required this.teams,required this.employees,required this.playersTeam});

  factory DataFromDB.fromJson(Map<String, dynamic> json) {

    final playersData = (json["data"]["players"] as List<dynamic>).map((e) => PlayerFromBackupDB.fromJson(e))
        .toList();
    final subData = (json["data"]["subscriptions"] as List<dynamic>).map((e) => SubscriptionsModel.fromJson(e))
        .toList();

    final teamsData = (json["data"]["teams"] as List<dynamic>).map((e) => TeamsFromDB.fromJson(e))
        .toList();

    final employeesData = (json["data"]["employees"] as List<dynamic>).map((e) => EmployeesData.fromJson(e))
        .toList();
    final playerTeamsData = (json["data"]["playerteam"] as List<dynamic>).map((e) => PlayerTeamFromDB.fromJson(e))
        .toList();

    return DataFromDB(
        players: playersData,
        employees: employeesData,
         playersTeam: playerTeamsData,
        subscriptions: subData, teams: teamsData);
  }
}


class ExcelPlayers{
  final int playerId;
  final String playerName;
  final int? playerPhoneNumber;
  final String? imagePath;
  final int? playerAge;
  final dynamic team;
  final String? playerFirstJoinDate;
  final String? playerGender;
  final int playerIndexId;
  final List<ExcelSubscriptionsModel>? subscriptions;

  ExcelPlayers( 
      {required this.playerId,
        required this.playerName,
        required this.playerPhoneNumber,
        required this.imagePath,
        required this.playerAge,
        required this.playerFirstJoinDate,
        required this.team,
        required this.playerGender,
        required this.playerIndexId,
        required this.subscriptions});

  factory ExcelPlayers.fromJson(Map<String, dynamic> json) {
    dynamic team ;
    if(json['team'].runtimeType == List<int>){
      team = (json['team'] as List<int> ).map((e) => e).toList();
    }else{
      team = json['team'];
    }

    final subscriptions = (json['subscriptions'] as List<dynamic>).map((e){

      return ExcelSubscriptionsModel.fromJson(e);
    } ).toList() ;
    return ExcelPlayers(
        team: team,
        playerId: json['id'],
        playerName: json['name'],
        playerPhoneNumber: json['playerPhoneNumber'],
        imagePath: json['imagePath'],
        playerAge: json['playerAge'],
        playerFirstJoinDate: json['playerFirstJoinDate'],
        playerGender: json['playerGender'],
        playerIndexId: json['playerIndexId'],
        
        subscriptions: subscriptions);
  }
}
class ExcelSubscriptionsModel {
  final int id;
  final String beginningDate;
  final String endDate;
  final int billid;
  final int billValue;
  final int duration;
  final int team;
  final String subscriptionCollectionDate;

  ExcelSubscriptionsModel( {
    required this.subscriptionCollectionDate,
    required this.team,
    required this.id,
    required this.beginningDate,
    required this.endDate,
    required this.billid,
    required this.billValue,
    required this.duration,
  });

  factory ExcelSubscriptionsModel.fromJson(Map<String, dynamic> json) {

    return ExcelSubscriptionsModel(
      subscriptionCollectionDate:json['subscriptionCollectionDate'],
        id: json["playerSubscriptionId"],
        beginningDate: json["beginDate"],
        endDate: json["finishDate"],
        billid: json["billId"],
        billValue: json['subscriptionValue'],
        duration: json["subscriptionDuration"],
        team: json['team'],
       );
  }


}
