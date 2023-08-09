import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';

part 'generate_table.g.dart';

@DriftDatabase(include:{'./players/players_data.drift','./subscriptions/subscriptions_info_table.drift'})

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