import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/view/widgets/employees_widget/edit_employee.dart';

import '../../../view/widgets/employees_widget/add_new_employee.dart';
import '../generate_table.dart';
import '../players/player_database_manager.dart';

class EmployeesDatabaseManager {
  SystemDatabase db = PlayersDatabaseManager.playersDatabase;

  Future insertEmployeesToDB(List<EmployeesTableCompanion> list) async {
    await db.batch((batch) => batch.insertAll(EmployeesTable(db), list));
  }

  Future<List<EmployeesTableData>> getEmployeesData() async {
    var employees = db.select(EmployeesTable(db))
      ..get();

    return await employees.get();
  }


  Future insertTrainer(EmployeesTableCompanion employee) async {
    await db.batch((batch) => batch.insert(EmployeesTable(db), employee));
  }

  Future insertEmployee(EmployeesTableCompanion employee,
      List<PermissionsModel> permission,) async {
    try {
      await db.transaction(() async {
        await db.into(EmployeesTable(db)).insert(employee);
        var employeeDataSelection = db.select(EmployeesTable(db))
          ..where((tbl) =>
              tbl.employeePhoneNumber.equals(
                  employee.employeePhoneNumber.value));
        EmployeesTableData employeesTableData = await employeeDataSelection
            .getSingle();

        List<EmployeesPermissionsCompanion> _list = [];

        for (var element in permission) {
          _list.add(EmployeesPermissionsCompanion.insert(
              employeeId: employeesTableData.employeeId,
              permission: element.permission));
        }
        await db.batch((batch) =>
            batch.insertAll(EmployeesPermissions(db), _list));

      });
      return 200;
    } catch (e) {
      debugPrint(e.toString());
      return 600;
    }
  }

  Future<List<GetEmployeeResult>> getEmployeeData(int id)async{
     return await db.getEmployee(id).get();
}

  Future editEmployeeData(EditedEmployeeModel data)async{
        if(data.employeePosition == 'Employee'){
            
        }
  }
}