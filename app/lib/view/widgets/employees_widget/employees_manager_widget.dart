

import 'package:fluent_ui/fluent_ui.dart';

import 'add_new_employee.dart';
import 'employees_list.dart';

class EmployeesManagerWidget extends StatelessWidget {
  const EmployeesManagerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      backgroundColor:Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Employees manager",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 31,color: Colors.yellow),),
          ),
         const Row(children: [
            AddNewEmployee(),
            EmployeesListWidget()
          ],)
        ],
    ),
      ),);
  }
}
