import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';

class GymLogsManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

    Future enterPlayer(String playerId,int teamId,context)async{
      if(int.tryParse(playerId) !=null){
        try{
          EnterPlayerToGymResult playerData = await db.enterPlayerToGym(int.parse(playerId) ,null ,teamId).getSingle();


          if( (DateTime.now().compareTo(playerData.freezeBeginDate!) ==1 && DateTime.now().compareTo(playerData.freezeBeginDate!) == -1 ) || DateTime(DateTime.now().year ,DateTime.now().month, DateTime.now().day).compareTo(DateTime(playerData.freezeBeginDate!.year,playerData.freezeBeginDate!.month,playerData.freezeBeginDate!.day)) == 0){
            await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is in freeze"),));

          }

        else  if(!playerData.mAXPlayersSubscriptionsendDate!.isBefore(DateTime.now()) && playerData.teamId == teamId){
            await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerIndexId:playerData.playerIndexId,playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now()));

            }

          else{
            await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is already ended"),));

          }
        }catch(err){
          await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("Wrong ID or name"),));
        }





      }

      else{

        try{
          EnterPlayerToGymResult playerData = await db.enterPlayerToGym(null, playerId,teamId).getSingle();

          if( (DateTime.now().compareTo(playerData.freezeBeginDate!) ==1 && DateTime.now().compareTo(playerData.freezeBeginDate!) == -1 ) || DateTime(DateTime.now().year ,DateTime.now().month, DateTime.now().day).compareTo(DateTime(playerData.freezeBeginDate!.year,playerData.freezeBeginDate!.month,playerData.freezeBeginDate!.day)) == 0){
            await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is in freeze"),));

          }
          else if(!playerData.mAXPlayersSubscriptionsendDate!.isBefore(DateTime.now()) && playerData.teamId == teamId && (playerData.freezeBeginDate == null || (  !playerData.freezeBeginDate!.isAfter(DateTime.now()) && !playerData.freezeEndDate!.isBefore(DateTime.now())))){
            await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));

          }


          else{
            await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is already ended"),));

          }
        }catch(err){
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