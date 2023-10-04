import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/employees/employees_data_manager.dart';
import 'package:gym_management/view/manage_excel/ui_widget.dart';
import '../../manage_excel/steps/coaches_data.dart';
import '../take_new_image_widget.dart';
import 'add_new_employee.dart';

Future showEditEmployeeWidget(context,int employeeId)async{
  await showGeneralDialog(context: context, pageBuilder: (context,animation,animation2)=> EditEmployeeWidget(employeeId:employeeId));
}

class EditEmployeeWidget extends StatefulWidget {
  final int employeeId;
  const EditEmployeeWidget({super.key,required this.employeeId});

  @override
  State<EditEmployeeWidget> createState() => _EditEmployeeWidgetState();
}

class EditedEmployeeModel{
  final int id;
  final String name;
  final String specialization;
  final String address;
  final String employeePosition;
  final List<PermissionsModel> permissions;

  EditedEmployeeModel({required this.id,required this.name, required this.specialization, required this.address, required this.employeePosition, required this.permissions});


}

class _EditEmployeeWidgetState extends State<EditEmployeeWidget> {
  List<PermissionsModel> selectedList = [];
 final TextEditingController _name =TextEditingController();
  final TextEditingController _specialization =TextEditingController();
  final TextEditingController _address =TextEditingController();
  int _phoneNumber = 20;
  int _nationalId = 20;
  int _salary = 20;
  int _commetion = 20;

  String _employeePosition = '';
  Future _setEmployeeData () async{


    await EmployeesDatabaseManager().getEmployeeData(widget.employeeId).then((val){

      setState(() {
        
        _name.text = val[0].employeeName;
        _specialization.text = val[0].employeeSpecialization;
        _address.text = val[0].employeeAddress;
        _phoneNumber = val[0].employeePhoneNumber;
        _nationalId = val[0].employeeNationalId;
        _employeePosition = val[0].employeePosition;
        _salary = val[0].employeeSalary.round();

      });
      for(var data in val){
        for (var data2  in permissionsList){
          if(data.permission == data2.permission){
           setState(() {
             data2.status = true;
             data2.id = data.id;
           });

            selectedList.add(data2);
          }else{
            selectedList.add(data2);
          }
        }
      }
    });
  }
  @override
  void initState() {
    _setEmployeeData ();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Card(child: Center(child: SizedBox(
        width: MediaQuery.sizeOf(context).width *0.91,
        height: MediaQuery.sizeOf(context).height *0.92,
        child: Card(backgroundColor: Colors.black, child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Edit employee",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow,fontSize: 23),),
                    IconButton(icon: const Icon(FluentIcons.cancel), onPressed: (){Navigator.pop(context);})
                  ],
                ),
              ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            SizedBox(
              width: 470,
              height:  MediaQuery.sizeOf(context).height *0.81,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TakeNewImageWidget(path: 'employee_national_id', state: nationalIdImageProvider),
                    ),
                    const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Text('Employee address'),
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
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: ComboBox(
                              items: jobStateList.map((e) => ComboBoxItem(value: e.title, child: Text( e.title)) ).toList(),
                              value: _employeePosition,
                              onChanged: (val) {
                                setState(() {
                                  _employeePosition = val!;
                                });
                              },

                             ),
                       ),
                        const SizedBox(width: 110,)
                      ],
                    ),
                    SizedBox(height: 10,),
                    const Divider(),
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

                    SizedBox(height: 6,),
                    if(_employeePosition == 'Employee')...{
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
                    }

                  ],
                ),
              ),
            ),

                if(_employeePosition == 'Employee')...{
                  Column(
                    children: [
                      SizedBox(
                        height: 500,
                        width: 600,
                        child:    Wrap(
                          children: permissionsList.map((e) => Padding(
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
                          )).toList(),
                        ),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("save changes"),
                        ),onPressed: (){},),
                      ),
                    ],
                  )
                }

                else ...{
                  Column(children: [
                    const SizedBox(
                      height: 500,
                      width: 600,
                      child: Center(child: Text("Freelance employees have no permissions"),),
                    ),
                    FilledButton(child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Text("save changes"),
                    ),onPressed: () async{
                      EditedEmployeeModel data = EditedEmployeeModel(name: _name.text, specialization: _specialization.text, address: _address.text, employeePosition: _employeePosition, permissions: selectedList, id: widget.employeeId);

                              await loadingDialog(context, -1, EmployeesDatabaseManager().editEmployeeData(data), null).then((value)async => await displayInfoBar(context, builder: (context,close)=>const InfoBar(title: Text("Edited successfully"))));


                    },)
                  ],)

                }







          ],)

        ],))),));
  }
}
