import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import '../generate_table.dart';

class TeamsDatabaseManager{
  static  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

  Future<List<TeamsDataTableData>> getAllTeams()async{
    var list = db.select(TeamsDataTable(db))..get();
    List<TeamsDataTableData> value = await list.get();
    return value;
  }

  Future insertTeamsToDB(List<TeamsDataTableCompanion> list) async{
      await db.batch((batch) => batch.insertAll(TeamsDataTable(db), list) );
  }

}