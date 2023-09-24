import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/view/manage_excel/ui_widget.dart';
import 'package:gym_management/view/screen.dart';
import 'package:gym_management/view/widgets/combo_box_widget.dart';
import '../database_management/tables/employees/employees_data_manager.dart';
import '../database_management/tables/teams/teams_database_manager.dart';
import 'manage_excel/steps/coaches_data.dart';

Future setEmployeesAndTeamsToDB(EmployeesTableCompanion employees,TeamsDataTableCompanion teams) async{
  // create employees companion

    // insert employees data
  try{
    await EmployeesDatabaseManager().insertEmployee(employees).then((_) async {
      int teamCaptainId = 0;
      int teamId = 0;
      // add captain id to each player
      await  EmployeesDatabaseManager().getEmployeesData().then((value) async{
        await TeamsDatabaseManager().getAllTeams().then((value) {
          teamId = value.last.teamId +1;
        });

        for(var employeesDB in value){

          if(employeesDB.employeeName == employees.employeeName.value){
            teamCaptainId =employeesDB.employeeId;
          }
        }
      });
      // create team companion
      TeamsDataTableCompanion newTeam = TeamsDataTableCompanion.insert(teamId: teamId, teamName: teams.teamName.value, teamCaptainId: teamCaptainId);
      await TeamsDatabaseManager().insertTeamToDB(newTeam);
    });
    return 200;
  }catch(e){
    print(e);
    return 400;
  }




}

Future showAddNewTeamWidget(context) async{
  await showGeneralDialog(context: context, pageBuilder: (context,animation,animation2)=>const AddNewTeamWidget());
}
class AddNewTeamWidget extends StatelessWidget {
  const AddNewTeamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(child: Center(child: SizedBox(width: 600,height: MediaQuery.sizeOf(context).height * 0.72,child: Card(backgroundColor: Colors.black,child: Column(children: [

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Add new team",style: TextStyle(fontSize: 21,color: Colors.yellow,fontWeight: FontWeight.bold),),
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          },
            icon:const Icon(FluentIcons.cancel),


          )
        ],
      ),

     const Expanded(child: AddNewTeamForm())

    ],),),),),);
  }
}

class AddNewTeamForm extends StatefulWidget {
  const AddNewTeamForm({super.key});

  @override
  State<AddNewTeamForm> createState() => _AddNewTeamFormState();
}

class _AddNewTeamFormState extends State<AddNewTeamForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _coachName = TextEditingController();
  final TextEditingController _teamName = TextEditingController();
  final TextEditingController _coachPhoneNumber = TextEditingController();
  final TextEditingController _coachAddress = TextEditingController();
  int _coachSalary = 0;
  int _coachPrivate = 0;
  String _coachEmploymentStatus = "";
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 1,
                        child: Text(
                          "Coach name:",
                        )),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            TextFormBox(
                              controller: _coachName,
                              validator: (val) {
                                if (val!.isEmpty || val == "") {
                                  return "please add coach name";
                                }
                                return null;
                              },

                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 2,
                        child: Text(
                          "Team name:",
                        )),
                    Expanded(
                        flex: 3,
                        child: TextFormBox(
                          validator: (val){
                            if(val == "" || val == null){
                              return "Please add Team name";
                            }return null;
                          },
                          controller: _teamName,
                        )),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 2,
                        child: Text(
                          "Coach phone:",
                        )),
                    Expanded(
                        flex: 3,
                        child: TextFormBox(
                          controller: _coachPhoneNumber,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (int.tryParse(val!) == null ||
                                val.length != 11) {
                              return "please add valid coach phone number";
                            }
                            return null;
                          },

                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 2,
                        child: Text(
                          "Coach address:",
                        )),
                    Expanded(
                        flex: 3,
                        child: TextFormBox(
                          controller: _coachAddress,
                          validator: (val) {
                            if (val!.isEmpty || val == "") {
                              return "please add coach name";
                            }
                            return null;
                          },

                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 3, child: Text('Coach employment status')),
                    Expanded(
                        flex: 2,
                        child: ComboBoxWidget(
                            items: jobStateList,
                            filterTitle: "",
                            onChanged: (val) {
                              setState(() {
                                _coachEmploymentStatus = val.title;
                              });

                            },
                            allButton: false)),
                  ],
                ),
              ),
              if (_coachEmploymentStatus == "Employee")
              // salary
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text(
                            "Coach salary:",
                          )),
                      Expanded(
                          flex: 3,
                          child: NumberFormBox(
                            onChanged: (val) {
                              setState(() {
                                _coachSalary = val!;
                              });

                            },
                            validator: (val) {
                              if (val == "0" || val == null) {
                                return "please add coach salary";
                              }
                              return null;
                            },
                            value: _coachSalary,
                          )),
                    ],
                  ),
                ),
              // salary
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 2,
                        child: Text(
                          "Coach private:",
                        )),
                    Expanded(
                        flex: 3,
                        child: NumberFormBox(
                          validator: (val) {
                            if (val == "0" || val == null) {
                              return "please add coach private";
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              _coachPrivate = val!;
                            });

                          },
                          value: _coachPrivate,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 12,),
              FilledButton(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Add team"),
              ), onPressed: () async {
                if(formKey.currentState!.validate()) {
                  TeamsDataTableCompanion teams =TeamsDataTableCompanion.insert(teamId: -1, teamName: _teamName.text, teamCaptainId: -1);
                  EmployeesTableCompanion employees = EmployeesTableCompanion.insert(employeeName: _coachName.text, employeePhoneNumber: int.parse(_coachPhoneNumber.text) , employeeSpecialization: "trainer", employeePosition: _coachEmploymentStatus, employeeAddress: _coachAddress.text);

                  await loadingDialog(context, -1,  setEmployeesAndTeamsToDB( employees, teams), null).then((value) {

                    Navigator.pop(context);
                    displayInfoBar(context, builder: (context,close) {

                      return  const InfoBar(
                          title: Text("Team added successfully"));
                    });

                    WidgetsBinding.instance.addPostFrameCallback((_){
                      Navigator.pushReplacement(context, FluentPageRoute(builder: (BuildContext context) { return const MainScreen(); }));
                    });
                  }

                      );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

