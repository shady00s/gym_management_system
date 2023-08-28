import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main_screen/widgets/combo_box_widget.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../model/sheets_model.dart';

class EmploymentModeModel {
  final String title;
  final String value;

  EmploymentModeModel(this.title, this.value);
}

List<EmploymentModeModel> _list = [
  EmploymentModeModel("Freelance", "Freelance"),
  EmploymentModeModel("Employee", "Employee"),
];

class SetCoachesWidget extends StatelessWidget {
  const SetCoachesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: Colors.black,
      child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.95,
          height: MediaQuery.sizeOf(context).height * 0.52,
          child: Column(
            children: [
              const Text("Setting coaches data"),
              Card(child: BlocBuilder<ExcelFileCubit, ImportExcelState>(
                builder: (BuildContext context, state) {
                  List<SheetsModel> selectedSheets =
                      ExcelFileCubit.get(context).selectedList;
                  List<GlobalKey<FormState>> keys =
                      ExcelFileCubit.get(context).keysFormList();
                  return SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    height: MediaQuery.sizeOf(context).height * 0.46,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: selectedSheets.map((selectedSheet) {
                          int indx = selectedSheets.indexOf(selectedSheet);
                          print(indx);
                          return CoachForm(
                              index: indx,
                              formKey: keys[indx],
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
  final TextEditingController _coachPhoneNumber = TextEditingController();
  final TextEditingController _coachAddress = TextEditingController();
  int _coachSalary = 0;
  String _coachEmploymentStatus = "";
  @override
  void initState() {
    _teamName.text = widget.teamName;
    _coachId.text = widget.coachId.toString();
    _coachPhoneNumber.text = "+20";

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
      child: Card(
        backgroundColor: Color.fromRGBO(12, 12, 12, 0.8),
        child: SizedBox(
          width: 270,
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
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Team name:",
                          )),
                      Expanded(
                          flex: 3,
                          child: TextFormBox(
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
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Team ID:",
                          )),
                      Expanded(
                          flex: 3,
                          child: TextFormBox(
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
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Coach phone:",
                          )),
                      Expanded(
                          flex: 3,
                          child: TextFormBox(
                            controller: _coachPhoneNumber,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Coach address:",
                          )),
                      Expanded(
                          flex: 3,
                          child: TextFormBox(
                            controller: _coachAddress,
                          )),
                    ],
                  ),
                ),
                ComboBoxWidget(
                    items: _list,
                    filterTitle: "Coach employment status",
                    onChanged: (val) {
                      setState(() {
                        _coachEmploymentStatus = val.title;
                      });
                    },
                    allButton: false),
                _coachEmploymentStatus == "Employee"
                    ? Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
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
                                  value: _coachSalary,
                                )),
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
