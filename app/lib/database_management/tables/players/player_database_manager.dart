import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';

import '../../models/backup_data_models.dart';

class PlayersDatabaseManager {
   static  SystemDatabase playersDatabase = SystemDatabase();
  final Dio _dio = Dio();

  Future getDataFromBackup() async {
    await _dio
        .get("http://127.0.1.1:3000/get_players_data_from_db")
        .then((playersValue) async {
      Map<String, dynamic> jsonData = playersValue.data;

      DataFromDB dataFromDB = DataFromDB.fromJson(jsonData);

      //  List playersData = dataFromDB.players;
      List<SubscriptionsModel> subData = dataFromDB.subscriptions;
      int length = await playersDatabase
          .select(Players(playersDatabase))
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
                playerFirstJoinDate: DateTime.parse(
                    data.player_first_join_date),
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

        await playersDatabase.batch((batch) =>
            batch.insertAll(Players(playersDatabase), [...players]));

        await playersDatabase.batch((batch) =>
            batch.insertAll(
                PlayersSubscriptions(playersDatabase), [...subscriptions]));
      }

      print("backup compelete");
    }).catchError((err) {
      print(err);
    });

    print("no backup ");
  }

  Future<List<GetAllNamesResult>> getPlayersData() async {
    return await playersDatabase.getAllNames().get();
  }

  Future<List<Player>> searchForPlayer(String searchInput) async {
    var res = playersDatabase.select(Players(playersDatabase))
      ..where((player) {
        int? value = int.tryParse(searchInput);
        if (value == null) {
          return player.playerName.like('%$searchInput%');
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
    var playerDb = Players(playersDatabase);
    var subDb = PlayersSubscriptions(playersDatabase);

    var sb = playersDatabase.select(subDb)
      ..where((tbl) => tbl.playerSubscriptionId.equals(id))
      ..orderBy([
            (tbl) =>
            OrderingTerm(expression: tbl.endDate, mode: OrderingMode.desc)
      ])
      ..get();

    var player = playersDatabase.select(playerDb)
      ..where((tbl) => tbl.playerId.equals(id))
      ..get();
    Player playerProfileData = await player.getSingle();
    List<PlayersSubscription> subData = await sb.get();
    return PlayerProfileData(playerProfileData, subData);
  }


  Future<List<Player>> getEndedSubscriptionsPlayers(DateTime dateTime,DateTime endDate) async {
    var date = playersDatabase.select(PlayersSubscriptions(playersDatabase))
      ..where((tbl) =>
          tbl.endDate.isBetweenValues(
              dateTime, endDate))
      ..get();
    List<PlayersSubscription> listData = await date.get();
    List<Player> date2 = [];
    for (var data in listData) {
      var x = playersDatabase.select(Players(playersDatabase))
        ..where((tbl) => tbl.playerId.equals(data.playerSubscriptionId))
        ..get();
      List<Player> p = await x.get();

      for (var data3 in p) {
        date2.add(data3);
      }
    }
    return date2;
  }

  Future <List<Player>> getNewPlayersSubscriptions(DateTime date) async {

    var players = playersDatabase.select(Players(playersDatabase))
      ..where((tbl) =>
          tbl.playerFirstJoinDate.isBetweenValues(
              date, DateTime.now()));

    return await players.get();
  }


  Future <List<Player>> getActivePlayersSubscriptions() async {
    var date = playersDatabase.select(PlayersSubscriptions(playersDatabase))
      ..where((tbl) =>
          tbl.endDate.isBiggerOrEqualValue(DateTime.now()))
      ..get();
    List<PlayersSubscription> listData = await date.get();
    List<Player> date2 = [];
    for (var data in listData) {
      var x = playersDatabase.select(Players(playersDatabase))
        ..where((tbl) => tbl.playerId.equals(data.playerSubscriptionId))
        ..get();
      List<Player> p = await x.get();

      for (var data3 in p) {
        date2.add(data3);
      }
    }
    return date2;
  }
}