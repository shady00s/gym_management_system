import 'package:drift/drift.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
class SubscriptionInformationManager{
static final SystemDatabase _database = SystemDatabase();
  insertSubscriptionInformation(SubscriptionsInformationData data)async{
    _database.into($SubscriptionsInformationTable(_database)).insert(SubscriptionsInformationCompanion.insert(subscriptionName: data.subscriptionName, subscriptionValue: data.subscriptionValue, subscriptionDuration: data.subscriptionDuration, subscriptionFreezeLimit: data.subscriptionFreezeLimit, subscriptionInvitationLimit: data.subscriptionInvitationLimit));
  }

 Future<List<SubscriptionsInformationData>> getAllSubscriptions()async{
    List<SubscriptionsInformationData> subscriptions =  await _database.select($SubscriptionsInformationTable(_database)).get();
    return subscriptions;
  }

  




}