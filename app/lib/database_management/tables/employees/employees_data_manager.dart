import '../generate_table.dart';
import '../players/player_database_manager.dart';

class EmployeesDatabaseManager{
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

  Future insertEmployeesToDB(List<EmployeesTableCompanion> list) async{
    await db.batch((batch) => batch.insertAll(EmployeesTable(db), list));
  }
  Future<List<EmployeesTableData>> getEmployeesData() async{
    var employees = db.select(EmployeesTable(db))..get();

    return await employees.get();
  }


  Future insertEmployee(EmployeesTableCompanion employee) async{
    await db.batch((batch) => batch.insert(EmployeesTable(db), employee));

  }
}