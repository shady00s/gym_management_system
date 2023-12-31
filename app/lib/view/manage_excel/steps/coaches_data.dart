import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/teams/teams_database_manager.dart';
import '../../widgets/combo_box_widget.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../model/sheets_model.dart';

class EmploymentModeModel {
  final String title;
  final String value;

  EmploymentModeModel(this.title, this.value);
}

List<CustomBoxData> jobStateList = [
  CustomBoxData(title: "Freelance", id: "Freelance"),
  CustomBoxData(title: "Employee", id: "Employee"),
];
Future<List<TeamsDataTableData>> getTeams = TeamsDatabaseManager().getAllTeams();
class SetCoachesWidget extends StatelessWidget {
  const SetCoachesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TeamsDataTableData>>(
      future: getTeams,
      builder: (BuildContext context,
          AsyncSnapshot<List<TeamsDataTableData>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
              child: Text("Error occured"),
            );
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: ProgressRing(),
            );
          case ConnectionState.done:
            if (snapshot.data!.isEmpty) {
              return Card(
                backgroundColor: Colors.black,
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    height: MediaQuery.sizeOf(context).height * 0.52,
                    child: Column(
                      children: [
                        const Text("Setting coaches data"),
                        Card(child:
                            BlocBuilder<ExcelFileCubit, ImportExcelState>(
                          builder: (BuildContext context, state) {
                            List<SheetsModel> selectedSheets =
                                ExcelFileCubit.get(context).selectedList;
                            List<GlobalKey<FormState>> keys =
                                ExcelFileCubit.get(context).globalKeyList;

                            WidgetsFlutterBinding.ensureInitialized();
                            return SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.95,
                              height: MediaQuery.sizeOf(context).height * 0.44,
                              child: SingleChildScrollView(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  alignment: WrapAlignment.center,
                                  children: selectedSheets.map((selectedSheet) {
                                    int idx =
                                        selectedSheets.indexOf(selectedSheet);
                                    return CoachForm(
                                        index: idx,
                                        formKey: keys[idx],
                                        coachId: selectedSheet.id,
                                        teamName: selectedSheet.name);
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        )),
                      ],
                    )),
              );
            }
            return Card(
                backgroundColor: Colors.black,
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    height: MediaQuery.sizeOf(context).height * 0.52,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FluentIcons.teamwork,size: 51,color:Colors.grey[80]),
                        const SizedBox(height: 21,),
                        const Text(
                            "All your selected teams data already found, you can change the data in teams manager"),
                        const SizedBox(height: 21,),

                        Button(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Continue to finish data step"),
                            ),
                            onPressed: () {
                              int index =
                                  ExcelFileCubit.get(context).currentIndex;
                              ExcelFileCubit.get(context)
                                  .incrementNumber(index + 1);
                            })
                      ],
                    )));
        }
      },
    );
  }
}

class CoachForm extends StatefulWidget {
  final int coachId;
  final String teamName;
  final GlobalKey<FormState> formKey;
  final int index;
  const CoachForm(
      {super.key,
      required this.coachId,
      required this.teamName,
      required this.formKey,
      required this.index});

  @override
  State<CoachForm> createState() => _CoachFormState();
}

class _CoachFormState extends State<CoachForm> {
  final TextEditingController _coachName = TextEditingController();
  final TextEditingController _teamName = TextEditingController();
  final TextEditingController _coachId = TextEditingController();
  final int _coachPhoneNumber = 20;
  final TextEditingController _coachAddress = TextEditingController();
  int _coachSalary = 0;
  int _coachPrivate = 0;
  String _coachEmploymentStatus = "";
  @override
  void initState() {
    _teamName.text = widget.teamName;
    _coachId.text = widget.coachId.toString();
    ExcelFileCubit.get(context)
        .employeesList[widget.index]
        .employeeSpecialization = "Trainer";
    ExcelFileCubit.get(context).employeesList[widget.index].employeePosition =
        "Freelance";
    ExcelFileCubit.get(context).employeesList[widget.index].teamId =
        widget.coachId;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
      child: Card(
        backgroundColor: const Color.fromRGBO(37, 34, 34, 0.4),
        child: SizedBox(
          width: 282,
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            "Name:",
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
                                onChanged: (val) {
                                  ExcelFileCubit.get(context)
                                      .employeesList[widget.index]
                                      .employeeName = val;
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
                            enabled: false,
                            readOnly: true,
                            controller: _teamName,
                          )),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text(
                            "Team ID:",
                          )),
                      Expanded(
                          flex: 3,
                          child: TextFormBox(
                            enabled: false,
                            readOnly: true,
                            controller: _coachId,
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
                          child: NumberFormBox(
                            mode: SpinButtonPlacementMode.none,
                            value: _coachPhoneNumber,
                            validator: (val) {
                              if(val.toString().length != 12) {
                                return "please add valid coach phone number";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              ExcelFileCubit.get(context)
                                  .employeesList[widget.index]
                                  .employeePhoneNumber = val!;
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
                                return "please add coach address";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              ExcelFileCubit.get(context)
                                  .employeesList[widget.index]
                                  .employeeAddress = val;
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

                                ExcelFileCubit.get(context)
                                    .employeesList[widget.index]
                                    .employeePosition = val.id;
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
                                ExcelFileCubit.get(context)
                                        .employeesList[widget.index]
                                        .employeeSalary =
                                    double.parse(val.toString());
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
                            onChanged: (val) {
                              setState(() {
                                _coachPrivate = val!;
                              });
                              ExcelFileCubit.get(context)
                                  .teamsList[widget.index]
                                  .teamPrivate = val!;
                            },
                            value: _coachPrivate,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
