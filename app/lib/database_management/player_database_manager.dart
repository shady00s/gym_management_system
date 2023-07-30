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
      List playersData = playersValue.data["data"]['players'];
      List subData = playersValue.data["data"]['subscriptions'];
      int length = await _playersDatabase
          .select($PlayersTable(_playersDatabase))
          .get()
          .then((value) => value.length);

      if (length == 0) {
        Iterable<Insertable<Player>> players = playersData.map((data) =>
            PlayersCompanion.insert(
                playerId: data["player_id"],
                playerName: data["player_name"],
                playerPhoneNumber: data["player_phone_number"],
                imagePath: data["image_path"],
                playerAge: data["player_age"],
                playerFirstJoinDate:
                    data["player_first_join_date"] ?? DateTime(2010 - 01 - 01),
                playerGender: data["player_gender"],
                subscriptionId: data["subscription_id"]));

        Iterable<PlayersSubscriptionsCompanion> subscriptions = subData.map((data) =>
            PlayersSubscriptionsCompanion.insert(
                playerSubscriptionId: data['player_subscription_id'],
                beginningDate: data['beginning_date'],
                endDate: data['end_date'],
                billId: data['billid'],
                duration: data['duration'],
                billValue: data['billvalue'],
                billCollector: data['billcollector']));

        await _playersDatabase.batch((batch) =>
            batch.insertAll($PlayersTable(_playersDatabase), [...players]));

        await _playersDatabase.batch((batch) => batch.insertAll(
            $PlayersSubscriptionsTable(_playersDatabase), [...subscriptions]));
      }
      print("backup compelete");
    }).catchError((err) {
      print(err);
    });

    print("no backup ");
  }

  Future<List<Player>> getPlayersData() async {
    var data = _playersDatabase.select($PlayersTable(_playersDatabase))..orderBy([
      (p)=>  OrderingTerm(expression: p.playerId,mode: OrderingMode.asc)
    ])..get();
    List<Player> responseData = await data.get();
    return responseData;
  }

  Future searchForPlayer(String searchInput) async {
    var res = _playersDatabase.select($PlayersTable(_playersDatabase))
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
    var playerDb = $PlayersTable(_playersDatabase);
    var subDb = $PlayersSubscriptionsTable(_playersDatabase);

    var sb = _playersDatabase.select(subDb)..where((tbl) => tbl.playerSubscriptionId.equals(id));

      var player =   _playersDatabase.select(playerDb)..where((tbl) => tbl.playerId.equals(id)) ;
      var playerProfileData = await player.get();
      var subData = await sb.get();
   return PlayerProfileData(playerProfileData[0],subData);

  }
}

class PlayerProfileData {
  final Player profileData;
  final List<PlayersSubscription> subData;

  PlayerProfileData(this.profileData, this.subData);


}