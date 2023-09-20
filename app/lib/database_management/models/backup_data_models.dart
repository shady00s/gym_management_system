import '../tables/generate_table.dart';

class PlayerProfileData {
  final Player profileData;
  final List<PlayersSubscription> subData;

  PlayerProfileData(this.profileData, this.subData);


}

class SubscriptionsModel {
  final int id;
  final String beginning_date;
  final String end_date;
  final int billid;
  final int billValue;
  final int duration;
  final int team;
  final String collector;
  SubscriptionsModel(
      {
        required this.team,
        required this.id,
        required this.beginning_date,
        required this.end_date,
        required this.billid,
        required this.billValue,
        required this.duration,
        required this.collector});

  factory SubscriptionsModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionsModel(
        id: json["player_subscription_id"],
        beginning_date: json["beginning_date"],
        end_date: json["end_date"],
        billid: json["billid"],
        billValue: json['billvalue'],
        duration: json["duration"],
        team: json['team'],
        collector: json['billcollector']);
  }


}

class PlayerFromBackupDB {
  final int player_id;
  final String player_name;
  final int player_phone_number;
  final String image_path;
  final int player_age;
  final String player_first_join_date;
  final String player_gender;
  final int subscription_id;
  final int playerIndexId;

  PlayerFromBackupDB(
      {required this.player_id,
        required this.player_name,
        required this.player_phone_number,
        required this.image_path,
        required this.player_age,
        required this.player_first_join_date,
        required this.player_gender,
        required this.subscription_id,
        required this.playerIndexId});

  factory PlayerFromBackupDB.fromJson(Map<String, dynamic> json) {
    return PlayerFromBackupDB(
        player_id: json['player_id'],
        player_name: json['player_name'],
        player_phone_number: json['player_phone_number'],
        image_path: json['image_path'],
        player_age: json['player_age'],
        player_first_join_date: json['player_first_join_date'],
        player_gender: json['player_gender'],
        subscription_id: json['subscription_id'], playerIndexId: json['player_index_id']);
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
  final int player_id;
  final String player_name;
  final int? player_phone_number;
  final String? image_path;
  final int? player_age;
  final dynamic team;
  final String? player_first_join_date;
  final String? player_gender;
  final int playerIndexId;
  final List<ExcelSubscriptionsModel>? subscriptions;

  ExcelPlayers( 
      {required this.player_id,
        required this.player_name,
        required this.player_phone_number,
        required this.image_path,
        required this.player_age,
        required this.player_first_join_date,
        required this.team,
        required this.player_gender,
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
        player_id: json['id'],
        player_name: json['name'],
        player_phone_number: json['playerPhoneNumber'],
        image_path: json['imagePath'],
        player_age: json['playerAge'],
        player_first_join_date: json['playerFirstJoinDate'],
        player_gender: json['playerGender'],
        playerIndexId: json['playerIndexId'],
        
        subscriptions: subscriptions);
  }
}
class ExcelSubscriptionsModel {
  final int id;
  final String beginning_date;
  final String end_date;
  final int billid;
  final int billValue;
  final int duration;
  final int team;
  final String subscriptionCollectionDate;

  ExcelSubscriptionsModel( {
    required this.subscriptionCollectionDate,
    required this.team,
    required this.id,
    required this.beginning_date,
    required this.end_date,
    required this.billid,
    required this.billValue,
    required this.duration,
  });

  factory ExcelSubscriptionsModel.fromJson(Map<String, dynamic> json) {
print({"tt":json['team'], "R":json['playerSubscriptionId']});

    return ExcelSubscriptionsModel(
      subscriptionCollectionDate:json['subscriptionCollectionDate'],
        id: json["playerSubscriptionId"],
        beginning_date: json["beginDate"],
        end_date: json["finishDate"],
        billid: json["billId"],
        billValue: json['subscriptionValue'],
        duration: json["subscriptionDuration"],
        team: json['team'],
       );
  }


}
