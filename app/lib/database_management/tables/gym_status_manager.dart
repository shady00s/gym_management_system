import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';

class GymStatusManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

  Future<int?> getMonthlyProfit(DateTime begValue,DateTime endVal)async{
    var data = await db.customSelect('''
       SELECT SUM(PlayersSubscriptions.billValue)  FROM PlayersSubscriptions
       WHERE PlayersSubscriptions.subscription_pay_date BETWEEN ?1 AND ?2 
  
    ''',readsFrom: {PlayersSubscriptions(db)},variables: [Variable.withDateTime(begValue),Variable.withDateTime(endVal)]).getSingle();
    return data.readNullable<int>("SUM(PlayersSubscriptions.billValue)");
  }



  Future<QueryRow> getBestAndWorstTeamsInfo (int year,int teamId) async{


    var data = await db.customSelect('''
        SELECT  TeamsDataTable.team_name, SUM(PlayersSubscriptions.billValue), COUNT(Players.player_name) FROM TeamsDataTable
        LEFT JOIN  PlayersSubscriptions ON  TeamsDataTable.team_id = PlayersSubscriptions.team_id 
        LEFT JOIN Players ON PlayersSubscriptions.player_subscription_id = Players.player_index_id
        WHERE PlayersSubscriptions.subscription_pay_date BETWEEN ?1 AND ?2 AND TeamsDataTable.team_id = ?3;
    ''',variables: ([Variable<DateTime>(DateTime(year,1,1)),Variable<DateTime>(DateTime(year,12,31)),Variable(teamId) ])).getSingle();
      return data;

  }
}