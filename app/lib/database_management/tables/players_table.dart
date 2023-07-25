import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
part 'players_table.g.dart';
class PlayersTable extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer()();
  TextColumn get playerName => text().withLength(min: 3, max: 90)();
  TextColumn get playerPhoneNumber =>text().withLength(min:11,max: 11)();
  TextColumn get imagePath => text()();
  IntColumn get playerAge => integer()();
  DateTimeColumn get playerFirstJoinDate => dateTime()();
  TextColumn get playerGender => text()();
  IntColumn get subscriptionId => integer()();

}

@DriftDatabase(tables:[PlayersTable])

class PlayersDatabase extends _$PlayersDatabase{
  PlayersDatabase():super(_openConnection());

  @override
  get schemaVersion => 1;
}

LazyDatabase _openConnection(){
  
  return LazyDatabase(() async{
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File(p.join(dir.path,'playersDatabase.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}