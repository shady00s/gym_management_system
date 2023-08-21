
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';

class GymLogsManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

    Future enterPlayer(int playerId,int teamId)async{
      await db.into(PlayersLogsTable(db)).insert(PlayersLogsTableCompanion.insert(playerId: playerId, teamId: teamId));
    }
    Future<List<GetTodayLogsResult>> getTodayPlayers() async{
      List<GetTodayLogsResult> logs= await db.getTodayLogs(DateTime.now()).get();

      return logs;
    }
}