
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/employees/employees_data_manager.dart';

import '../../../database_management/tables/generate_table.dart';
import 'edit_employee.dart';


var getListOfEmployeesProvider = FutureProvider.autoDispose<List<EmployeesTableData>>((ref) => EmployeesDatabaseManager().getEmployeesData());
class EmployeesListWidget extends StatelessWidget {
  const EmployeesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 550,
        height: 500,
        child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          var employeesData = ref.watch(getListOfEmployeesProvider);
      return employeesData.when(
          skipLoadingOnRefresh: false,
          data: (data)=> data.isNotEmpty? ListView.builder(itemCount: data.length, itemBuilder: (BuildContext context, int index) => Padding(padding: EdgeInsets.all(8),child: EmployeeCardWidget(data: data[index],),),):Column(children: [
        
        Icon(FluentIcons.people_add,size: 42,color: Colors.grey[80],),
        Text("No employees found")
      ],), error: (err,state)=>Center(child: Text(err.toString()),), loading: ()=>Center(child: ProgressBar(),));
    },));
  }
}

class EmployeeCardWidget extends StatelessWidget {
  final EmployeesTableData data;
  const EmployeeCardWidget({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Button(

        onPressed:()async{await showEditEmployeeWidget(context,data.employeeId);},
        child: Row(children: [
             data.employeeImage =='no-image'?const   CircleAvatar(
               radius: 23,
               backgroundColor: Color.fromRGBO(
                   176, 175, 175, 0.7019607843137254),
               child: Icon(FluentIcons.contact ,size: 21,),
             ): Image(image: FileImage(File(data.employeeImage)),width: 90,),

          SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.employeeName,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data.employeeSpecialization,style: TextStyle(color: Colors.grey[80]),),
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(FluentIcons.phone,color: Colors.grey[80],size: 12,),
                ),Text(data.employeePhoneNumber.toString())
              ],)
            ],),
          const Spacer()
          ,IconButton(icon: Icon(FluentIcons.delete), onPressed: (){})
        ],),
      ),
    );
  }
}
