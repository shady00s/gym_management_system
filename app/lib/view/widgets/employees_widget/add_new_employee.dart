import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/employees/employees_data_manager.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/view/manage_excel/ui_widget.dart';
import 'package:gym_management/view/widgets/employees_widget/employees_list.dart';
import 'package:gym_management/view/widgets/take_new_image_widget.dart';

import '../../manage_excel/steps/coaches_data.dart';
import '../combo_box_widget.dart';


var nationalIdImageProvider = StateProvider<String?>((ref) => null);
class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({super.key});

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class PermissionsModel {
  final String permission;
  late bool status;
  final String info;
  int? id;
  PermissionsModel({required this.permission, required this.status,required this.info ,required this.id});
}

final List<PermissionsModel> permissionsList = [
  PermissionsModel(permission: 'Edit players information', status: false,info: 'Edit name, phone number, profile image', id: null),
  PermissionsModel(permission: 'See Gym financial statements', status: false,info: 'See if gym loss / profit data', id: null),
  PermissionsModel(permission: 'Create/Edit Subscriptions', status: false,info: 'create subscriptions for all teams or edit them', id: null),
  PermissionsModel(permission: 'Import data from excel', status: false,info: 'Import data from excel and control database to reset/add extra data', id: null),
  PermissionsModel(permission: 'Create/Edit Teams', status: false,info: 'create teams and add coaches data', id: null),
  PermissionsModel(permission: 'Create/Edit employees', status: false,info: 'create gym employees', id: null),
  PermissionsModel(permission: 'See players logs', status: false,info: 'see all players that came on specific date', id: null),
  PermissionsModel(permission: 'See employees logs', status: false,info: 'see all employees that came on specific date', id: null),
];

class _AddNewEmployeeState extends State<AddNewEmployee> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();


  TextEditingController _name =TextEditingController();
  TextEditingController _specialization =TextEditingController();
  TextEditingController _address =TextEditingController();
  int _phoneNumber = 20;
  int _nationalId = 20;
  int _salary = 20;
  int _commetion = 20;

  String _employeePosition = 'Freelance';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SizedBox(
        width: 561,
        height: 541,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add new employee",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 241,
                    child: TextFormBox(
                      placeholder: 'Name:',
                      controller: _name,
                      validator: (val){
                        if(val ==''){
                          return 'Please add employee name';
                        }
                        return null;
                      },
                    )),
              ),
              SizedBox(height: 6,),
              Text('National ID'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 241,
                    child: NumberFormBox(
                      placeholder: 'National ID:',
                      mode: SpinButtonPlacementMode.none,
                      value: _nationalId,
                      onChanged: (val){
                        setState(() {
                          _nationalId = val!;
                        });
                      },
                      validator: (val){
                        if(val == null || val.length < 12){
                          return 'Please add valid National ID';
                        }
                        return null;
                      },
                    )),
              ),
              SizedBox(height: 6,),
              Text('phone number'),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 241,
                  child: NumberFormBox(
                    placeholder: 'Phone number:',
                    mode: SpinButtonPlacementMode.none,
                    value: _phoneNumber,
                    onChanged: (val){
                      setState(() {
                        _phoneNumber = val!;
                      });
                    },
                    validator: (val){
                      if(val == null || val.length <12 ){
                        return 'Please add valid Phone number';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const Divider(),
              const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Text('National ID image',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('Employee address'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TakeNewImageWidget(path: 'employee_national_id', state: nationalIdImageProvider),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 241,
                    child: TextFormBox(
                      placeholder: 'Address:',
                      controller: _address,
                      validator: (val){
                        if(val =='' || val == null){
                          return 'Please add employee address';
                        }
                        return null;
                      },
                    )),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding:  EdgeInsets.symmetric(vertical:15.0),
                    child: Text("Employee position:"),
                  ),
                  ComboBoxWidget(
                      items: jobStateList,
                      filterTitle: "",
                      onChanged: (val) {
                        setState(() {
                          _employeePosition = val.title;
                        });
                      },

                      allButton: false),
                 const SizedBox(width: 110,)
                ],
              ),
              const Divider(),

              if(_employeePosition == 'Employee')...{
                const Padding(
                  padding: EdgeInsets.all(8.0),

                  child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Employee permission",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),

                Wrap(
                  children: permissionsList
                      .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Checkbox(
                        checked: e.status,
                        content: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.permission,style: const TextStyle(fontWeight: FontWeight.w600),),
                             const SizedBox(height: 8,),
                              SizedBox(width: 200,child:  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(e.info,style: TextStyle(color: Colors.grey[80]),),
                              ),)

                            ],
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            e.status = !e.status;
                          });
                        }),
                  ))
                      .toList(),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 241,
                      child: TextFormBox(
                        placeholder: 'Employee specialization:',
                        controller: _specialization,
                        validator: (val){
                          if(val ==''){
                            return 'Please add employee specialization';
                          }
                          return null;
                        },
                      )),
                ),
                SizedBox(height: 6,),
                Text('Employee salary:'),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 241,
                      child: NumberFormBox(
                        placeholder: 'Employee salary:',
                        value: _salary,
                        onChanged: (val){
                          setState(() {
                            _salary = val!;
                          });

                        },
                        validator: (val){
                          if(val == null || val == '0'){
                            return 'Please add valid employee salary';
                          }
                          return null;
                        },
                      )),
                ),
              },
              SizedBox(height: 6,),
              Text('Employee commission/Private:'),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 241,
                    child: NumberFormBox(
                      placeholder: 'Employee commission/Private:',
                      value: _commetion,
                      onChanged: (val){
                        setState(() {
                          _commetion = val!;
                        });
                      },
                      validator: (val){
                        if(val == null || val == '0'){
                          return 'Please add valid employee commission';
                        }
                        return null;
                      },
                    )),
              ),
              SizedBox(height: 18,),
              Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
             String?  nationalId =  ref.watch(nationalIdImageProvider);

             return FilledButton(child:const Padding(
               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
               child:  Text("Add employee"),
             ), onPressed: () async{
               List<PermissionsModel> permissions = [];

               if(_key.currentState!.validate()){

                 EmployeesTableCompanion employee = EmployeesTableCompanion.insert(
                     employeeName: _name.text, employeePhoneNumber: _phoneNumber,
                     employeeSpecialization: _specialization.text, employeePosition: _employeePosition,
                     employeeAddress: _address.text, employeeNationalId: _nationalId,
                     employeeNationalIdImage: nationalId??'no-image');

                 for (var element in permissionsList) {

                   if(element.status){
                     permissions.add(element);
                   }
                 }
               await loadingDialog(context, -1, EmployeesDatabaseManager().insertEmployee(employee, permissions), null).then((value) async{

                 ref.invalidate(getListOfEmployeesProvider);
               await displayInfoBar(context, builder: (context, close) => InfoBar(title: Text('Succssess'))
              );} ) ;

               }
             });
              },)
            ],
          ),
        ),
      ),
    );
  }
}
