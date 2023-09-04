import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';

class GymLogsManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

    Future enterPlayer(String playerId,int teamId,context)async{
      if(int.tryParse(playerId) !=null){
        try{
          EnterPlayerToGymResult playerData = await db.enterPlayerToGym(int.parse(playerId) ,null ,teamId).getSingle();
          if(!playerData.endDate!.difference(DateTime.now()).isNegative && playerData.teamId == teamId){
            await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerIndexId:playerData.playerIndexId,playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now()));

            }else{
            await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is already ended"),));

          }
        }catch(err){
          await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("Wrong ID or name"),));
        }





      }

      else{

        try{
          EnterPlayerToGymResult playerData = await db.enterPlayerToGym(null, playerId,teamId).getSingle();

          if(!playerData.endDate!.difference(DateTime.now()).isNegative && playerData.teamId == teamId){
            await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData.playerId, teamId: playerData.teamId!, playerEntranceDate: DateTime.now(), playerIndexId: playerData.playerIndexId));

          }else{
            await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("This player subscription is already ended"),));

          }
        }catch(err){
          await showDialog(context: context, builder: (context)=>const ContentDialog(content: Text("Wrong ID or name"),));
        }

      }
    }
    Future<List<GetTodayLogsResult>> getTodayPlayers(teamId) async{

      List<GetTodayLogsResult> logs=  await db.getTodayLogs(DateTime.now().subtract(const   Duration(hours: 15)),DateTime.now(),teamId).get();

      return  logs;
    }

    Future<List<DateTime>> getPlayerLogs(int playerIndexId, int teamId) async{
      return await  db.getTodayPlayerLogs(playerIndexId, teamId,DateTime(DateTime.now().year,DateTime.now().month,1),DateTime.now()).get();
    }
}