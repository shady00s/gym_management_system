import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';

class GymStatusManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;
  
  Future getYearProfit(DateTime begValue,DateTime endVal)async{
    List<QueryRow> data = await db.customSelect('''
      SELECT SUM(PlayersSubscriptions.billValue)  FROM PlayersSubscriptions
      WHERE PlayersSubscriptions.subscription_pay_date BETWEEN ?1 AND ?2
  
    ''',readsFrom: {PlayersSubscriptions(db)},variables: [Variable.withDateTime(begValue),Variable.withDateTime(endVal)]).get();

   for(QueryRow element in data){
     print(element.data);
   }
  }

  Future getMonthlyProfit(DateTime year, int month)async{

  }


  Future<int?> getBestMonthInProfit(DateTime begValue,DateTime endVal)async{
    var data = await db.customSelect('''
       SELECT SUM(PlayersSubscriptions.billValue)  FROM PlayersSubscriptions
    WHERE PlayersSubscriptions.subscription_pay_date BETWEEN ?1 AND ?2 
  
    ''',readsFrom: {PlayersSubscriptions(db)},variables: [Variable.withDateTime(begValue),Variable.withDateTime(endVal)]).getSingle();
    return data.readNullable<int>("SUM(PlayersSubscriptions.billValue)");
  }
}