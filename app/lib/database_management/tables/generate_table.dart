import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';

part 'generate_table.g.dart';

@DriftDatabase(include:{'./employees/employees.drift','./teams/teams.drift','./players/players_data.drift','./teams/players_teams.drift','./subscriptions/subscriptions_info_table.drift','./gym_player_logs/gym_logs_data.drift'})

class SystemDatabase extends _$SystemDatabase{
  SystemDatabase():super(_openConnection());

  @override
  get schemaVersion => 1;
}



LazyDatabase _openConnection(){
  
  return LazyDatabase(() async{
    final File file = File(p.join("assets",'database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}