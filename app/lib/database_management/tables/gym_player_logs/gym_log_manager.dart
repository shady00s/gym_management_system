import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/view/widgets/re-subscription/re_subscription_widget.dart';

import '../../../view/manage_excel/ui_widget.dart';



class GymLogsManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

  Future<int> _addPlayerToLogs(playerData)async{
    try{
      await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));

      return 200;
    }catch(e){
      print(e);
      return 400;
    }
  }


    Future enterPlayer(String playerID,int teamId,context)async{

        dynamic playerId = int.tryParse(playerID);
      if(playerId !=null){
        try{
          EnterPlayerToGymResult playerData = await db.enterPlayerToGym(playerId, null,teamId).getSingle();
          if(playerData.mAXPlayersSubscriptionsendDate!.isAfter(DateTime.now()) && teamId == playerData.teamId ){
            if( playerData.freezeBeginDate == null ){
              await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));

            } else{
              // check if freeze begin date is today
              if(playerData.freezeBeginDate!.day == DateTime.now().day &&  playerData.freezeBeginDate!.month == DateTime.now().month && playerData.freezeBeginDate!.year == DateTime.now().year ){

                await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is in freeze"),));
                // check if datetime is after begin date of before end date (freeze duration) or end date is equal to today
              }else if (DateTime.now().isAfter(playerData.freezeBeginDate!)  && (DateTime.now().isBefore(playerData.freezeEndDate!)|| playerData.freezeEndDate!.day == DateTime.now().day &&  playerData.freezeEndDate!.month == DateTime.now().month && playerData.freezeEndDate!.year == DateTime.now().year )){
                await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is in freeze"),));

              }else{
                await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));

              }
            }
          }
          else if(playerData.teamId != teamId){
            await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player is not belonging to this team"),));

          }
          else if( DateTime.now().difference(playerData.mAXPlayersSubscriptionsendDate!).inDays <= 2){
            await showDialog(context: context, builder: (context)=> ContentDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subscription status"),
                    IconButton(icon: const Icon(FluentIcons.cancel), onPressed: (){Navigator.pop(context); })
                  ],),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("This player subscription is ended, but he/she can enter"),
                  ],
                ),
                actions:[
                  Button(child: const Text("Cancel"), onPressed: (){Navigator.pop(context);}),

                  FilledButton(child: const Text("Enter to gym"), onPressed: ()async{
                  await loadingDialog(context,-1,_addPlayerToLogs(playerData),null ).then((value) => Navigator.pop(context));
                })]

            ));
          }else{
            await showDialog(context: context, builder: (context)=> ContentDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subscription status"),
                    IconButton(icon: const Icon(FluentIcons.cancel), onPressed: (){Navigator.pop(context); })
                  ],),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("This player subscription is ended, but he/she cannot enter"),
                  ],
                ),
                actions:[
                  Button(child: const Text("Cancel"), onPressed: (){Navigator.pop(context);}),
                  FilledButton(child: const Text("Go to Re-subscribe"), onPressed: ()async{
                  showReSubscriptionWidget(context, playerData.playerIndexId);
                })]

            ),
            );
                }
        }catch(err){
          print(err);
          await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("Wrong ID or name"),));
        }

      }

      else{

        try{
          EnterPlayerToGymResult playerData = await db.enterPlayerToGym(null, playerId,teamId).getSingle();
          if(playerData.mAXPlayersSubscriptionsendDate!.isAfter(DateTime.now()) && teamId == playerData.teamId ){
            if( playerData.freezeBeginDate == null ){
              await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));

            } else{
              // check if freeze begin date is today
              if(playerData.freezeBeginDate!.day == DateTime.now().day &&  playerData.freezeBeginDate!.month == DateTime.now().month && playerData.freezeBeginDate!.year == DateTime.now().year ){

                await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is in freeze"),));
                // check if datetime is after begin date of before end date (freeze duration) or end date is equal to today
              }else if (DateTime.now().isAfter(playerData.freezeBeginDate!)  && (DateTime.now().isBefore(playerData.freezeEndDate!)|| playerData.freezeEndDate!.day == DateTime.now().day &&  playerData.freezeEndDate!.month == DateTime.now().month && playerData.freezeEndDate!.year == DateTime.now().year )){
                await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is in freeze"),));

              }else{
                await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));

              }
            }
          }
          else if(playerData.teamId != teamId){
            await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player is not belonging to this team"),));

          }
          else if( DateTime.now().difference(playerData.mAXPlayersSubscriptionsendDate!).inDays <= 2){
            await showDialog(context: context, builder: (context)=> ContentDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subscription status"),
                    IconButton(icon: const Icon(FluentIcons.cancel), onPressed: (){Navigator.pop(context); })
                  ],),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("This player subscription is ended, but he/she can enter"),
                  ],
                ),
                actions:[FilledButton(child: const Text("Enter to gym"), onPressed: ()async{
                  await loadingDialog(context,-1,_addPlayerToLogs(playerData),null );
                })]

            ));
          }else{
            await showDialog(context: context, builder: (context)=> ContentDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subscription status"),
                    IconButton(icon: const Icon(FluentIcons.cancel), onPressed: (){Navigator.pop(context); })
                  ],),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("This player subscription is ended, but he/she cannot enter"),
                  ],
                ),
                actions:[FilledButton(child: const Text("Go to Re-subscribe"), onPressed: ()async{
                  showReSubscriptionWidget(context, playerData.playerIndexId);
                })]

            ),
            );
          }
        }catch(err){
          print(err);
          await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("Wrong ID or name"),));
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