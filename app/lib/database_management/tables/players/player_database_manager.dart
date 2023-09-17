import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import '../../models/backup_data_models.dart';

class PlayersDatabaseManager {
   static  SystemDatabase playersDatabase = SystemDatabase();
  final Dio _dio = Dio();

  // Future getDataFromBackup() async {
  //   await _dio
  //       .get("http://127.0.1.1:3000/get_players_data_from_db")
  //       .then((playersValue) async {
  //     Map<String, dynamic> jsonData = playersValue.data;
  //
  //     DataFromDB dataFromDB = DataFromDB.fromJson(jsonData);
  //
  //     //  List playersData = dataFromDB.players;
  //     List<SubscriptionsModel> subData = dataFromDB.subscriptions;
  //     int length = await playersDatabase
  //         .select(Players(playersDatabase))
  //         .get()
  //         .then((value) => value.length);
  //
  //     if (length == 0) {
  //       Iterable<Insertable<Player>> players = dataFromDB.players.map((data) =>
  //           PlayersCompanion.insert(
  //               playerId: data.player_id,
  //               playerName: data.player_name,
  //               playerPhoneNumber: data.player_phone_number,
  //               imagePath: data.image_path,
  //               playerAge: data.player_age,
  //               playerFirstJoinDate: DateTime.parse(
  //                   data.player_first_join_date),
  //               playerGender: data.player_gender,
  //               subscriptionId: data.subscription_id, playerIndexId: data.playerIndexId));
  //
  //       Iterable<Insertable<PlayersSubscription>> subscriptions =
  //       subData.map((data) {
  //         return PlayersSubscriptionsCompanion.insert(
  //             playerSubscriptionId: data.id,
  //             beginningDate: DateTime.parse(data.beginning_date),
  //             endDate: DateTime.parse(data.end_date),
  //             billId: data.billid,
  //             duration: data.duration,
  //             billValue: data.billValue,
  //             billCollector: data.collector, teamId: null);
  //       });
  //
  //       Iterable<TeamsDataTableCompanion> teams = dataFromDB.teams.map((e) => TeamsDataTableCompanion.insert(teamName: e.teamName!, teamCaptainId: e.teamCaptainId!, teamId: e.teamId!));
  //       Iterable<EmployeesTableCompanion> employees = dataFromDB.employees.map((e) => EmployeesTableCompanion.insert(employeeName: e.employeeName!, employeePhoneNumber: e.employeePhoneNumber!, employeeSpecialization:e.employeeSpecialization!, employeePosition:e.employeePosition!, employeeSalary: e.employeeSalary!, employeeAddress: e.employeeAddress!));
  //       Iterable<PlayersAndTeamsTableCompanion> playerTable = dataFromDB.playersTeam.map((e) => PlayersAndTeamsTableCompanion.insert(teamId: e.teamId!, teamPlayerId: e.teamPlayerId!));
  //       await playersDatabase.batch((batch) => batch.insertAll(EmployeesTable(playersDatabase), employees));
  //       await playersDatabase.batch((batch) => batch.insertAll(TeamsDataTable(playersDatabase), teams));
  //       await playersDatabase.batch((batch) => batch.insertAll(Players(playersDatabase), [...players]));
  //       await playersDatabase.batch((batch) => batch.insertAll(PlayersSubscriptions(playersDatabase), [...subscriptions]));
  //       await playersDatabase.batch((batch) => batch.insertAll(PlayersAndTeamsTable(playersDatabase), playerTable));
  //
  //
  //     }
  //
  //
  //
  //     print("backup compelete");
  //   }).catchError((err) {
  //     print(err);
  //   });
  //
  //   print("no backup ");
  // }

  Future dropPlayersAndSubscriptionsTable()async{
    await playersDatabase.delete(PlayersAndTeamsTable(playersDatabase)).go();
    await playersDatabase.delete(Players(playersDatabase)).go();
    await playersDatabase.delete(PlayersSubscriptions(playersDatabase)).go();
  }

  Future<List<GetAllNamesResult>> getPlayersData() async {
    return await playersDatabase.getAllNames().get();
  }

  Future<List<GetPlayersByTeamResult>> getPlayersByTeam(int id) async{
  List<GetPlayersByTeamResult> players =  await  playersDatabase.getPlayersByTeam(id).get();
   return players;

  }

  Future<List<Player>> searchForPlayer(String searchInput) async {
    var res = playersDatabase.select(Players(playersDatabase))
      ..where((player) {
        int? value = int.tryParse(searchInput);
        if (value == null) {
          return player.playerName.like('%$searchInput%');
        } else if (searchInput.length < 11) {
          return player.playerIndexId.equals(value);
        } else {
          return player.playerPhoneNumber.equals(value);
        }
      })
      ..get();



    return await res.get();
  }

  Future<List<GetPlayerSubscriptionResult>> getPlayerSubscriptionInfo(int id) async {

    List<GetPlayerSubscriptionResult>result =  await playersDatabase.getPlayerSubscription(id).get();

    return result;
  }

  Future <List<TeamsDataTableData>> getPlayerTeams(int id) async{
    return await playersDatabase.getPlayerTeam(id).get();
  }

  Future<List<Player>> getEndedSubscriptionsPlayers(var data) async {

    List<Player> players =   await playersDatabase.filterEndedSubPlayers(data['duration']['id'].begDate, data['duration']['id'].endDate,data['subscription']['id'], data['coach']['id']).get();
  return players;
  }

  Future <List<Player>> getNewPlayersSubscriptions(var data) async {

 var x = await playersDatabase.filterNewPlayers(data['duration']['id'].begDate, data['duration']['id'].endDate,data['subscription']['id'], data['coach']['id']).get();
    return x;
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
        ..where((tbl) => tbl.playerIndexId.equals(data.playerSubscriptionId))
        ..get();
      List<Player> p = await x.get();

      for (var data3 in p) {
        date2.add(data3);
      }
    }
    return date2;
  }

   Future<List<GetEndedSubscriptionByTeamResult>> getNeedToResubscribePlayersSubscriptions(teamId) async {

     List<GetEndedSubscriptionByTeamResult>  data = await playersDatabase.getEndedSubscriptionByTeam( DateTime.now().subtract(const Duration(days: 20)),DateTime.now(),teamId,).get();
     return data;
   }

Future insertPlayersFromExcelOffline(List<ExcelPlayers> playersData)async{

    Iterable <PlayersCompanion> playersCompanion = playersData.map((playerData) => PlayersCompanion.insert(playerIndexId: playerData.playerIndexId, playerId: playerData.player_id, playerName: playerData.player_name, playerPhoneNumber: -1, imagePath: "no image", playerAge: -1, playerFirstJoinDate: DateTime.parse(playerData.subscriptions![0].beginning_date), playerGender: "un recorded", subscriptionId: playerData.playerIndexId));

    //get teams data
    List<PlayersAndTeamsTableCompanion> playersTeamCompanion = [];
    for(var player in playersData){
      if(player.team.runtimeType != int){
        for (var team in player.team){
          playersTeamCompanion.add(PlayersAndTeamsTableCompanion.insert(teamId: team, teamPlayerId: player.playerIndexId));
        }
      }else{
        playersTeamCompanion.add(PlayersAndTeamsTableCompanion.insert(teamId: player.team, teamPlayerId: player.playerIndexId));
      }

    }

    List<PlayersSubscriptionsCompanion>  playersSubCompanion= [];
    for(var player in playersData){
      for( var subData in player.subscriptions!){
        playersSubCompanion.add(
            PlayersSubscriptionsCompanion.insert( playerSubscriptionId: subData.id, beginningDate: DateTime.parse(subData.beginning_date), endDate: DateTime.parse(subData.end_date), billId: subData.billid, billValue: subData.billValue, duration: subData.duration, billCollector: "unknown", teamId: subData.team, subscriptionPayDate: DateTime.parse(subData.subscriptionCollectionDate), freezeAvailable: 0, invitationAvailable: 0 )
        );
      }
    }


      await playersDatabase.batch((batch) => batch.insertAll(Players(playersDatabase), playersCompanion)).then((value) async{
          await playersDatabase.batch((batch) => batch.insertAll(PlayersSubscriptions(playersDatabase), playersSubCompanion)).then((value) async{
          await playersDatabase.batch((batch) => batch.insertAll(PlayersAndTeamsTable(playersDatabase), playersTeamCompanion));

        });
    });



}


Future reSubscribePlayer(PlayersSubscriptionsCompanion data)async{
    try{
      await playersDatabase.into(PlayersSubscriptions(playersDatabase)).insert(data);

    }catch(e){
      throw e.toString();
    }
   }

   Future<GetRemainingInvitationResult> getInvitations(int playerIndexId) async{
     GetRemainingInvitationResult invitations = await playersDatabase.getRemainingInvitation(playerIndexId).getSingle();
    return invitations;
   }
   Future<GetRemainingFreezeResult> getFreeze(int playerIndexId) async{
     GetRemainingFreezeResult freeze = await playersDatabase.getRemainingFreeze(playerIndexId).getSingle();
     return freeze;
   }
   Future<int> addNewPlayer(PlayersCompanion player,PlayersSubscriptionsCompanion sub)async{
    try{
      var players =  playersDatabase.select(Players(playersDatabase))..where((tbl) => tbl.playerPhoneNumber.equals(player.playerPhoneNumber.value))..get();
      List<Player> playersList = await players.get();
      if (playersList.isEmpty) {
        playersDatabase.transaction(() async{
          await playersDatabase.into(Players(playersDatabase)).insert(player);
          await playersDatabase.into(PlayersSubscriptions(playersDatabase)).insert(sub);
          await playersDatabase.into(PlayersAndTeamsTable(playersDatabase)).insert(PlayersAndTeamsTableCompanion.insert(teamId: sub.teamId.value, teamPlayerId: player.playerIndexId.value));
        });
        return 200;
      }else{
        return 600;
      }

    }catch(e){
      print(e);
      return 400;
    }

   }
   Future<int> createPlayerId()async{
    List<Player> db = await playersDatabase.select(Players(playersDatabase)).get();

    return db.length +1;
   }

   Future<int> freezePlayerSubscription(int subscriptionId,DateTime freezeBeginningDate, DateTime freezeEndDate,int freezeDuration ,DateTime subscriptionEndDate) async{

     var playerUpdated =  playersDatabase.update(PlayersSubscriptions(playersDatabase))..where((tbl) => tbl.subId.equals(subscriptionId));

     try{
         await playerUpdated.write(PlayersSubscriptionsCompanion(freezeBeginDate:Value(freezeBeginningDate),endDate: Value(subscriptionEndDate.add(Duration(days: freezeDuration))) ,freezeEndDate: Value(freezeEndDate),freezeAvailable:const Value(0) ));
      return 200;
     }catch(e){
       return 400;
     }
   }
}
