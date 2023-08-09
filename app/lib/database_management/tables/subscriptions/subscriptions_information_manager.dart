import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
class SubscriptionInformationManager extends PlayersDatabaseManager{

  SystemDatabase db = PlayersDatabaseManager.playersDatabase;
 Future insertSubscriptionInformation(SubscriptionsInfoTableData data)async{
   db.into(SubscriptionsInfoTable(db)).insert(SubscriptionsInfoTableCompanion.insert(subscriptionName: data.subscriptionName, subscriptionValue: data.subscriptionValue, subscriptionDuration: data.subscriptionDuration, subscriptionFreezeLimit: data.subscriptionFreezeLimit, subscriptionInvitationLimit: data.subscriptionInvitationLimit));
  }

 Future<List<SubscriptionsInfoTableData>> getAllSubscriptions()async{
    List<SubscriptionsInfoTableData> subscriptions =  await db.select(SubscriptionsInfoTable(db)).get();
    return subscriptions;
  }


  Future editSubscriptionData (int id ,SubscriptionsInfoTableData data)async{

      await db.update(SubscriptionsInfoTable(db)).replace(SubscriptionsInfoTableCompanion(
        id: Value(id),
          subscriptionName:Value(data.subscriptionName),
          subscriptionDuration: Value(data.subscriptionDuration),
          subscriptionFreezeLimit: Value(data.subscriptionFreezeLimit),
          subscriptionInvitationLimit: Value(data.subscriptionInvitationLimit),
          subscriptionValue: Value(data.subscriptionValue)

      ));
  }

  Future deleteSubscriptionData(int id)async{
     db.delete(SubscriptionsInfoTable(db))..where((tbl) => tbl.id.equals(id))..go();
  }




}