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
  final String collector;
  SubscriptionsModel(
      {required this.id,
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

class DataFromDB {
  final List<PlayerFromBackupDB> players;
  final List<SubscriptionsModel> subscriptions;

  DataFromDB({required this.players, required this.subscriptions});

  factory DataFromDB.fromJson(Map<String, dynamic> json) {

    final playersData = (json["data"]["players"] as List<dynamic>).map((e) => PlayerFromBackupDB.fromJson(e))
        .toList();
    final subData = (json["data"]["subscriptions"] as List<dynamic>).map((e) => SubscriptionsModel.fromJson(e))
        .toList();



    return DataFromDB(
        players: playersData
        ,
        subscriptions: subData);
  }
}
