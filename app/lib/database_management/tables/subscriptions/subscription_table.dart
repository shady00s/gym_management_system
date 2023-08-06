import 'package:drift/drift.dart';

class SubscriptionsInformation extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subscriptionName => text()();
  TextColumn get subscriptionValue => text()();
  TextColumn get subscriptionDuration => text()();
  IntColumn get subscriptionFreezeLimit => integer()();
  IntColumn get subscriptionInvitationLimit => integer()();
}

