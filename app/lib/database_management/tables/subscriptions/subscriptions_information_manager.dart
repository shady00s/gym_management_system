import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';

import '../../models/subscriptions_with_team_model.dart';
class SubscriptionInformationManager extends PlayersDatabaseManager{

  SystemDatabase db = PlayersDatabaseManager.playersDatabase;
 Future insertSubscriptionInformation(SubscriptionsInfoTableData data)async{
   db.into(SubscriptionsInfoTable(db)).insert(SubscriptionsInfoTableCompanion.insert(subscriptionName: data.subscriptionName, subscriptionValue: data.subscriptionValue, subscriptionDuration: data.subscriptionDuration, subscriptionFreezeLimit: data.subscriptionFreezeLimit, subscriptionInvitationLimit: data.subscriptionInvitationLimit, teamId: 0));
  }

 Future<List<SubscriptionsInfoTableData>> getAllSubscriptions()async{
    List<SubscriptionsInfoTableData> subscriptions =  await db.select(SubscriptionsInfoTable(db)).get();
    return subscriptions;
  }

  Future<List<SubscriptionsWithTeamModel>> getAllSubscriptionsInformation()async{

    List<TypedResult> data = await db.select(SubscriptionsInfoTable(db)).join([innerJoin(TeamsDataTable(db), TeamsDataTable(db).teamId.equalsExp(SubscriptionsInfoTable(db).teamId))]).get();

    List<SubscriptionsWithTeamModel> result = [];
    for (var element in data) {
          result.add(SubscriptionsWithTeamModel(subName: element.readTable(SubscriptionsInfoTable(db)).subscriptionName, teamName: element.readTable(TeamsDataTable(db)).teamName, teamPrivate: element.readTable(TeamsDataTable(db)).teamPrivate, subInvitation: element.readTable(SubscriptionsInfoTable(db)).subscriptionInvitationLimit, subFreeze: element.readTable(SubscriptionsInfoTable(db)).subscriptionFreezeLimit, subValue: element.readTable(SubscriptionsInfoTable(db)).subscriptionValue, subDuration: element.readTable(SubscriptionsInfoTable(db)).subscriptionDuration));
    }
    return result;
 }


    Future<List<SubscriptionsInfoTableData>> getAllSubscriptionsOrdered()async{
    var subscriptions =   db.select(SubscriptionsInfoTable(db))..orderBy([
      (u)=>OrderingTerm(expression:  u.subscriptionValue,mode: OrderingMode.asc)
    ])..get();
    return await subscriptions.get();
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