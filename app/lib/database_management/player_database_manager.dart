import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/players_table.dart';

class PlayersDatabaseManager {
  static final PlayersDatabase _playersDatabase = PlayersDatabase();
  final Dio _dio = Dio();

  Future getDataFromBackup() async {
    await _dio
        .get("http://127.0.1.1:3000/get_players_data_from_db")
        .then((playersValue) async {

      Map<String, dynamic> jsonData = playersValue.data;

      DataFromDB dataFromDB = DataFromDB.fromJson(jsonData);

    //  List playersData = dataFromDB.players;
      List<SubscriptionsModel> subData = dataFromDB.subscriptions;
      int length = await _playersDatabase
          .select(Players(_playersDatabase))
          .get()
          .then((value) => value.length);

      if (length == 0) {
        Iterable<Insertable<Player>> players = dataFromDB.players.map((data) =>
            PlayersCompanion.insert(
                playerId: data.player_id,
                playerName: data.player_name,
                playerPhoneNumber: data.player_phone_number,
                imagePath: data.image_path,
                playerAge: data.player_age,
                playerFirstJoinDate: data.player_first_join_date,
                playerGender: data.player_gender,
                subscriptionId: data.subscription_id));

        Iterable<Insertable<PlayersSubscription>> subscriptions =
            subData.map((data) {
          return PlayersSubscriptionsCompanion.insert(
              playerSubscriptionId: data.id,
              beginningDate: DateTime.parse(data.beginning_date),
              endDate: DateTime.parse(data.end_date),
              billId: data.billid,
              duration: data.duration,
              billValue: data.billValue,
              billCollector: data.collector);
        });

        await _playersDatabase.batch((batch) =>
            batch.insertAll(Players(_playersDatabase), [...players]));

        await _playersDatabase.batch((batch) => batch.insertAll(
            PlayersSubscriptions(_playersDatabase), [...subscriptions]));
      }

      print("backup compelete");
    }).catchError((err) {
      print(err);
    });

    print("no backup ");
  }

  Future<List<GetAllNamesResult>> getPlayersData() async {
    return await _playersDatabase.getAllNames().get();
  }

  Future searchForPlayer(String searchInput) async {
    var res = _playersDatabase.select(Players(_playersDatabase))
      ..where((player) {
        int? value = int.tryParse(searchInput);
        if (value == null) {
          return player.playerName.equals(searchInput);
        } else if (searchInput.length < 11) {
          return player.playerId.equals(value);
        } else {
          return player.playerPhoneNumber.equals(value);
        }
      })
      ..get();
    return await res.get();
  }

  Future<PlayerProfileData> getPlayerSubscriptionInfo(int id) async {
    var playerDb = Players(_playersDatabase);
    var subDb = PlayersSubscriptions(_playersDatabase);

    var sb = _playersDatabase.select(subDb)
      ..where((tbl) => tbl.playerSubscriptionId.equals(id))
      ..get();

    var player = _playersDatabase.select(playerDb)
      ..where((tbl) => tbl.playerId.equals(id))
      ..get();
    Player playerProfileData = await player.getSingle();
    List<PlayersSubscription> subData = await sb.get();
    return PlayerProfileData(playerProfileData, subData);
  }

  Future getEndedSubscriptionPlayers() async {
    _playersDatabase.select(PlayersSubscriptions(_playersDatabase));
  }
}

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

  PlayerFromBackupDB(
      {required this.player_id,
      required this.player_name,
      required this.player_phone_number,
      required this.image_path,
      required this.player_age,
      required this.player_first_join_date,
      required this.player_gender,
      required this.subscription_id});

  factory PlayerFromBackupDB.fromJson(Map<String, dynamic> json) {
    return PlayerFromBackupDB(
        player_id: json['player_id'],
        player_name: json['player_name'],
        player_phone_number: json['player_phone_number'],
        image_path: json['image_path'],
        player_age: json['player_age'],
        player_first_join_date: json['player_first_join_date'],
        player_gender: json['player_gender'],
        subscription_id: json['subscription_id']);
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
