import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import '../../../view/manage_excel/model/sheets_model.dart';
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

  Future insertTeamToDB(TeamsDataTableCompanion list) async{
    await db.batch((batch) => batch.insert(TeamsDataTable(db), list) );
  }
  Future<List<TeamsDataTableData>>   checkIfTeamsExists(List<SheetsModel> list)async{

     List<String> nameList = list.map((e)=>e.name).toList();
     var teams =  db.select(TeamsDataTable(db))..where((tbl) => tbl.teamName.isIn(nameList))..get();
     return await teams.get();
    }

}