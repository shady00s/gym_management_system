
import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';

class GymLogsManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

    Future enterPlayer(String playerId,int teamId)async{
      if(int.tryParse(playerId) !=null){
        await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId:int.parse(playerId) , teamId: teamId,playerEntranceDate:DateTime.now()));

      }else{
        var playerSelectedData =  db.select(Players(db))..where((tbl) => tbl.playerName.like(playerId))..getSingle();
       List<Player> playerData = await playerSelectedData.get();
        await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerData[0].playerId, teamId: teamId,playerEntranceDate:DateTime.now()));


      }
    }
    Future<List<GetTodayLogsResult>> getTodayPlayers(teamId) async{
print(teamId);
      List<GetTodayLogsResult> logs=  await db.getTodayLogs(DateTime.now().subtract(Duration(days: 1)),DateTime.now(),teamId).get();

      return  logs;
    }
}