import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
part 'players_table.g.dart';
class Players extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer()();
  TextColumn get playerName => text().withLength(min: 2, max: 90)();
  IntColumn get playerPhoneNumber =>integer()();
  TextColumn get imagePath => text()();
  IntColumn get playerAge => integer()();
  DateTimeColumn get playerFirstJoinDate => dateTime()();
  TextColumn get playerGender => text()();
  IntColumn get subscriptionId => integer()();

}

class PlayersSubscriptions extends Table{
  IntColumn get subId => integer().autoIncrement()();
  IntColumn get playerSubscriptionId => integer()();
  TextColumn get beginningDate => text()();
  TextColumn get endDate => text()();
  IntColumn get billId => integer()();
  IntColumn get duration => integer()();
  IntColumn get billValue => integer()();
  TextColumn get billCollector => text()();

}

@DriftDatabase(tables:[Players,PlayersSubscriptions])

class PlayersDatabase extends _$PlayersDatabase{
  PlayersDatabase():super(_openConnection());

  @override
  get schemaVersion => 1;
}


LazyDatabase _openConnection(){
  
  return LazyDatabase(() async{
    final File file = File(p.join("assets",'PlayersDatabase2.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}