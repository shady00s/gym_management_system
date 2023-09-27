import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/view/widgets/re-subscription/re_subscription_widget.dart';

class GymLogsManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

    Future enterPlayer(String playerID,int teamId,context,isInvitation)async{
     int? playerId = int.tryParse(playerID);
     print(playerId);
     print(playerID);
      if( playerId !=null){
        try{
          EnterPlayerToGymResult playerData = await db.enterPlayerToGym(teamId,playerId ,null ).getSingle();


          if(isInvitation){
            await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));
              return;
          }
          if( playerData.teamId == teamId ){
            if( playerData.freezeBeginDate == null ){
              await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));
              return;

            }


            else if(playerData.mAXPlayersSubscriptionsendDate!.difference(DateTime.now()).inDays <=3){
              await showDialog(context: context, builder: (context)=>
                  ContentDialog(
                      content: const Text("This player subscription ended but can enter"),
                      actions: [
                        FilledButton(child: const Text("Re-subscribe"), onPressed: ()async{await showReSubscriptionWidget(context, playerData.playerIndexId);}),

                        FilledButton(child: const Text("Enter player"), onPressed: ()async{
                          await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId)).then((value){
                            Navigator.pop(context);
                            WidgetsBinding.instance.addPostFrameCallback((_) async{
                              await displayInfoBar(context, builder: (context,close)=>const InfoBar(title: Text("Player entered successfully")));
                            });
                          });

                        }),
                        Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})]));
            }
            else{
              // check if freeze begin date is today
              if(playerData.freezeBeginDate!.day == DateTime.now().day &&  playerData.freezeBeginDate!.month == DateTime.now().month && playerData.freezeBeginDate!.year == DateTime.now().year ){

                await showDialog(context: context, builder: (context)=>
                    ContentDialog(
                  content: const Text("This player subscription is in freeze"),
                  actions: [Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})],
                ));
                // check if datetime is after begin date of before end date (freeze duration) or end date is equal to today
              }else if (DateTime.now().isAfter(playerData.freezeBeginDate!)  && (DateTime.now().isBefore(playerData.freezeEndDate!)|| playerData.freezeEndDate!.day == DateTime.now().day &&  playerData.freezeEndDate!.month == DateTime.now().month && playerData.freezeEndDate!.year == DateTime.now().year )){
                await showDialog(context: context, builder: (context)=> ContentDialog(
                  content: const Text("This player subscription is in freeze"),
                  actions: [Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})],
                ));

              }else{
                await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));

              }
            }
          }
          else if(playerData.teamId != teamId){
            await showDialog(context: context, builder: (context)=> ContentDialog(content: Text("This player is not belonging to this team, he/she belongs to ${playerData.subscriptionName}",

            ),
              actions: [Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})],
            ));

          }
          else{
            await showDialog(context: context, builder: (context)=> ContentDialog(content: const Text("This player subscription is ended"),
              actions: [
                FilledButton(child: const Text("Re-subscribe"), onPressed: ()async{await showReSubscriptionWidget(context, playerData.playerIndexId);}),
                Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})],
            ));

          }
        }catch(err){
          print(err);
          await showDialog(context: context, builder: (context)=> ContentDialog(content: const Text("Wrong ID or name"),

            actions: [Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})],

          ));
        }
      }

      else{

        try{
          EnterPlayerToGymResult playerData = await db.enterPlayerToGym(teamId,null, playerID,).getSingle();
          if(isInvitation){
            await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));
            return;
          }
          if(playerData.mAXPlayersSubscriptionsendDate!.isAfter(DateTime.now()) && teamId == playerData.teamId ){
            if( playerData.freezeBeginDate == null ){
              await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));
           return;

            }
            else if(playerData.mAXPlayersSubscriptionsendDate!.difference(DateTime.now()).inDays <=3){
              await showDialog(context: context, builder: (context)=>
                  ContentDialog(
                      content: const Text("This player subscription subscription ended but can enter"),
                      actions: [
                        FilledButton(child: const Text("Re-subscribe"), onPressed: ()async{await showReSubscriptionWidget(context, playerData.playerIndexId);}),
                        FilledButton(child: const Text("Enter player"), onPressed: ()async{
                          await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId)).then((value){
                            Navigator.pop(context);
                            WidgetsBinding.instance.addPostFrameCallback((_) async{
                              await displayInfoBar(context, builder: (context,close)=>const InfoBar(title: Text("Player entered successfully")));
                            });
                          });

                        }),
                        Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})]));
            }


            else{
              // check if freeze begin date is today
              if(playerData.freezeBeginDate!.day == DateTime.now().day &&  playerData.freezeBeginDate!.month == DateTime.now().month && playerData.freezeBeginDate!.year == DateTime.now().year ){

                await showDialog(context: context, builder: (context)=> ContentDialog(content: const Text("This player subscription is in freeze",)
                  ,actions: [Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})],

                ),);
                // check if datetime is after begin date of before end date (freeze duration) or end date is equal to today
              }else if (DateTime.now().isAfter(playerData.freezeBeginDate!)  && (DateTime.now().isBefore(playerData.freezeEndDate!)|| playerData.freezeEndDate!.day == DateTime.now().day &&  playerData.freezeEndDate!.month == DateTime.now().month && playerData.freezeEndDate!.year == DateTime.now().year )){
                await showDialog(context: context, builder: (context)=> ContentDialog(

                  content: const Text("This player subscription is in freeze"),
                 actions: [Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})],
                ));

              }else{
                await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));

              }
            }
          }
           if(playerData.teamId != teamId){
            await showDialog(context: context, builder: (context)=> ContentDialog(content: Text("This player is not belonging to this team, he/she belongs to ${playerData.subscriptionName}"),
              actions: [Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})],
            ));

          } else{
            await showDialog(context: context, builder: (context)=> ContentDialog(content: const Text("This player subscription is ended"),
              actions: [
                FilledButton(child: const Text("Re-subscribe"), onPressed: ()async{await showReSubscriptionWidget(context, playerData.playerIndexId);}),
                Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})

              ],
            ));

          }
        }catch(err){
          print(err);
          await showDialog(context: context, builder: (context)=> ContentDialog(content: const Text("Wrong ID or name"),
            actions: [Button(child: const Text("Close"), onPressed: (){Navigator.pop(context);})],
          ));
        }

      }
    }
    Future<List<GetTodayLogsResult>> getTodayPlayers(teamId) async{
      DateTime now = DateTime.now();
      List<GetTodayLogsResult> logs=  await db.getTodayLogs(DateTime(now.year,now.month,now.day,0,0,0),DateTime(now.year,now.month,now.day,0,0,0).add(const Duration(days: 1)),teamId).get();

      return  logs;
    }

    Future<List<DateTime>> getPlayerLogs(int playerIndexId, int teamId) async{
      return await  db.getTodayPlayerLogs(playerIndexId, teamId,DateTime(DateTime.now().year,DateTime.now().month,1),DateTime.now()).get();
    }

    Future<DateTime?> getPlayerLastSeen(playerIndex,teamId)async{

      return await db.getLastPlayerLog(playerIndex, teamId).getSingle();
    }

  Future<List<GetListOfPlayersLogsResult>> getListOfPlayersLogs(int? teamId,DateTime date)async{
      return await db.getListOfPlayersLogs(teamId, date,date.add(const Duration(hours: 23))).get();
    }
}