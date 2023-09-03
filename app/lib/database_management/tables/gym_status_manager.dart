import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';

class GymStatusManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;
  
  Future getYearProfit(DateTime begValue)async{
  var data = await db.customSelect('''
      SELECT SUM(PlayersSubscriptions.billValue)  FROM PlayersSubscriptions
      WHERE PlayersSubscriptions.subscription_pay_date BETWEEN ? AND DATE('NOW')
  
    ''',readsFrom: {PlayersSubscriptions(db)},variables: [Variable.withDateTime(begValue)]).get();

   for(var element in data){
     print(element.data);
   }
  }


  Future getBestMonthInProfit(DateTime begValue,DateTime endVal)async{
    var data = await db.customSelect('''
      SELECT SUM(PlayersSubscriptions.billValue)  FROM PlayersSubscriptions
      WHERE PlayersSubscriptions.subscription_pay_date BETWEEN ?1 AND ?2
  
    ''',readsFrom: {PlayersSubscriptions(db)},variables: [Variable.withDateTime(begValue),Variable.withDateTime(endVal)]).get();

    for(var element in data){
      print(element.data);
    }
  }
}