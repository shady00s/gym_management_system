import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/gym_player_logs/gym_log_manager.dart';
import 'package:gym_management/view/widgets/re-subscription/re_subscription_widget.dart';
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
    try{
      playersDatabase.transaction(() async{
        await playersDatabase.delete(PlayersAndTeamsTable(playersDatabase)).go();
        await playersDatabase.delete(Players(playersDatabase)).go();
        await playersDatabase.delete(PlayersLogsTable(playersDatabase)).go();
        await playersDatabase.delete(PlayersSubscriptions(playersDatabase)).go();

      });
     return 200;
    }catch(e){
      print(e);
      return 400;
    }

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

     List<GetEndedSubscriptionByTeamResult>  data = await playersDatabase.getEndedSubscriptionByTeam(teamId,DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day), DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).subtract(const Duration(days: 20)),).get();
     return data;
   }

Future insertPlayersFromExcelOffline(List<ExcelPlayers> playersData)async{
    try{
      Iterable <PlayersCompanion> playersCompanion = playersData.map((playerData) => PlayersCompanion.insert(playerIndexId: playerData.playerIndexId, playerId: playerData.playerId, playerName: playerData.playerName, playerPhoneNumber: -1, imagePath: "no image", playerAge: -1, playerFirstJoinDate: DateTime.parse(playerData.subscriptions![0].beginningDate), playerGender: "un recorded", subscriptionId: playerData.playerIndexId));

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
              PlayersSubscriptionsCompanion.insert( playerSubscriptionId: subData.id, beginningDate: DateTime.parse(subData.beginningDate), endDate: DateTime.parse(subData.endDate), billId: subData.billid, billValue: subData.billValue, duration: subData.duration, billCollector: "unknown", teamId: subData.team, subscriptionPayDate: DateTime.parse(subData.subscriptionCollectionDate), freezeAvailable: 0, invitationAvailable: 0, subscriptionInfoId: -1 )
          );
        }
      }


      await playersDatabase.batch((batch) => batch.insertAll(Players(playersDatabase), playersCompanion)).then((value) async{
        await playersDatabase.batch((batch) => batch.insertAll(PlayersSubscriptions(playersDatabase), playersSubCompanion)).then((value) async{
          await playersDatabase.batch((batch) => batch.insertAll(PlayersAndTeamsTable(playersDatabase), playersTeamCompanion));

        });
      });

      return 200;

    }catch(e){

      print(e);
      return 400;
    }



}


Future reSubscribePlayer(PlayersSubscriptionsCompanion data, RemainingData? remainingData)async{
    try{

      if(remainingData != null){
        await playersDatabase.transaction(() async{
          await playersDatabase.into(PlayersSubscriptions(playersDatabase)).insert(data);
          await playersDatabase.update(Players(playersDatabase)).write(PlayersCompanion(playerPhoneNumber: Value(remainingData.playerPhoneNumber),playerGender: Value(remainingData.playerGender?? 'un recorded'), imagePath: Value(remainingData.playerImagePath)));

        });
        return 200;
      }else{
        await playersDatabase.into(PlayersSubscriptions(playersDatabase)).insert(data);
        return 200;
      }

    }catch(e){
      print( e.toString());
      return 600;
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
   Future<Player?> searchForInvitation(int phoneNumber)async{
    try{
      PlayersSubscriptions playersSub = PlayersSubscriptions(playersDatabase);
      var player = playersDatabase.select(Players(playersDatabase))..join([
        innerJoin(playersSub,playersSub.playerSubscriptionId.equalsExp(Players(playersDatabase).playerIndexId))
      ])..where((tbl) =>tbl.playerPhoneNumber.equals(phoneNumber))..getSingle();

      Player result  = await player.getSingle();

      return result;
    }catch(e){
      print(e);
      return null;
    }

   }


   Future<int> addNewPlayerFromInvitation(PlayersCompanion player,int teamId,invitationDonorId,context)async{

  try{
    var invitation=  playersDatabase.select(SubscriptionsInfoTable(playersDatabase))..where((tbl) => tbl.teamId.equals(teamId)  )..where((tbl) => tbl.subscriptionValue.equals(0))..where((tbl) => tbl.subscriptionValue.equals(0));
    var invitationData = await invitation.getSingle();

    var playerSubscription= playersDatabase.select(PlayersSubscriptions(playersDatabase))..where((tbl) => tbl.teamId.equals(teamId))..where((tbl) => tbl.playerSubscriptionId.equals(invitationDonorId))..orderBy([(clauses)=>OrderingTerm(expression: clauses.endDate,mode: OrderingMode.desc)])..limit(1)..getSingle();
    var playerSubscriptionsDetails = await playerSubscription.getSingle();


    playersDatabase.transaction(() async{
      await playersDatabase.into(Players(playersDatabase)).insert(player);
      await playersDatabase.into(PlayersSubscriptions(playersDatabase)).insert(PlayersSubscriptionsCompanion.insert(teamId: teamId,
          freezeAvailable: invitationData.subscriptionFreezeLimit, invitationAvailable: invitationData.subscriptionInvitationLimit,
          subscriptionPayDate: DateTime.now(), playerSubscriptionId: player.playerIndexId.value, beginningDate: DateTime.now(),
          endDate: DateTime.now(), billId: 0, billValue: 0, duration: 999999, billCollector: "unknown", subscriptionInfoId: invitationData.id!));
      await playersDatabase.into(PlayersAndTeamsTable(playersDatabase)).insert(PlayersAndTeamsTableCompanion.insert(teamId: teamId, teamPlayerId: player.playerIndexId.value));

      await GymLogsManager().enterPlayer(player.playerId.value.toString(), teamId, context,true);

      var playerInvitationUpdate =   playersDatabase.update(PlayersSubscriptions(playersDatabase))..where((tbl) => tbl.subId.equals(playerSubscriptionsDetails.subId!));
      await playerInvitationUpdate.write(PlayersSubscriptionsCompanion(invitationAvailable: Value(playerSubscriptionsDetails.invitationAvailable -1)));
    });

    return 200;
  }catch(e){
    print(e);
    return 400;
  }


   }


   Future checkForInvitationValidation(int guestPlayerId,int donorPlayerId,int teamId,context) async{
    await showDialog(context: context, builder: (context) {
      Future.delayed(Duration.zero,() async{
        try{
          CheckForInvitationValidationResult getGuestData  = await playersDatabase.checkForInvitationValidation(guestPlayerId).getSingle();
          if(getGuestData.mAXPlayersSubscriptionsendDate!.difference(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,00,00,00)).isNegative&& DateTime.now().isAfter(getGuestData.mAXPlayersSubscriptionsendDate!)){
            var invitation=  playersDatabase.select(SubscriptionsInfoTable(playersDatabase))..where((tbl) => tbl.teamId.equals(teamId)  )..where((tbl) => tbl.subscriptionValue.equals(0));
            var invitationData = await invitation.getSingle();
            var playerSubscription= playersDatabase.select(PlayersSubscriptions(playersDatabase))..where((tbl) => tbl.teamId.equals(teamId))..where((tbl) => tbl.playerSubscriptionId.equals(donorPlayerId))..orderBy([(clauses)=>OrderingTerm(expression: clauses.endDate,mode: OrderingMode.desc)])..limit(1)..getSingle();
            var playerSubscriptionsDetails = await playerSubscription.getSingle();
            try{
              playersDatabase.transaction(() async{
                await playersDatabase.into(PlayersSubscriptions(playersDatabase)).insert(PlayersSubscriptionsCompanion.insert(teamId: teamId,
                    freezeAvailable: invitationData.subscriptionFreezeLimit, invitationAvailable: invitationData.subscriptionInvitationLimit,
                    subscriptionPayDate: DateTime.now(), playerSubscriptionId: guestPlayerId, beginningDate: DateTime.now(),
                    endDate: DateTime.now(), billId: 0, billValue: 0, duration: 999999, billCollector: "unknown", subscriptionInfoId: invitationData.id!)).then((value)async => await GymLogsManager().enterPlayer(getGuestData.playerId.toString(), teamId, context,true));

                var playerInvitationUpdate =   playersDatabase.update(PlayersSubscriptions(playersDatabase))..where((tbl) => tbl.subId.equals(playerSubscriptionsDetails.subId!));
                await playerInvitationUpdate.write(PlayersSubscriptionsCompanion(invitationAvailable: Value(playerSubscriptionsDetails.invitationAvailable -1)));
              }).then((value)async{
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pop(context);
                });

                  await displayInfoBar(context, builder: (context,close)=>const InfoBar(title: Text("Successfully added")));});

            }catch(e){
                print(e);
              WidgetsBinding.instance.addPostFrameCallback((_) async{
                await showDialog(context: context, builder:(context)=> const ContentDialog(content: Text("Error occured"),)).then((value) => Navigator.pop(context));


              });

            }

          }

          else {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await showDialog(context: context, builder: (context) =>
              const ContentDialog(content: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "This player subscription is already subscribed you cannot invite him/her"),
              )),).then((value) => Navigator.pop(context));


            });
          }
        }catch(e){
          print(e);
        }
      });
      return const ContentDialog(
            content: ProgressBar(),
          );
        });





  }
}
