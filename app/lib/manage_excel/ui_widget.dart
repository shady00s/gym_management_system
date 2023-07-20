
import "package:fluent_ui/fluent_ui.dart";
import "package:flutter/material.dart" as material;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gym_management/manage_excel/cubit/state.dart";
import "package:gym_management/manage_excel/steps/import_excel_step.dart";
import "package:gym_management/manage_excel/steps/set_cols_rows.dart";

import "cubit/cubit.dart";

class ImportExcelScreen extends StatelessWidget {
  const ImportExcelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Text("Setting Data"),
      ),
      content: Padding(padding: EdgeInsets.all(14), child: StepsWidget()),
    );
  }
}

class StepsWidget extends StatefulWidget {
  const StepsWidget({super.key});

  @override
  State<StepsWidget> createState() => _StepsWidgetState();
}

class _StepsWidgetState extends State<StepsWidget> {
  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
        body: BlocProvider<ExcelFileCubit>(
      create: (context) => ExcelFileCubit(),
      child: BlocConsumer<ExcelFileCubit, ImportExcelState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, currentState) {
          ExcelFileCubit state = ExcelFileCubit.get(context);

          int newIndex = state.currentIndex;
          int newNumber = newIndex;
          return material.Stepper(

            onStepTapped: (index){
              state.incrementNumber(index);
            },
              onStepContinue:(){
              if(state.excelFile !=null ){
                state.incrementNumber(newNumber+1);
              }else if(state.excelFile ==null){
                showDialog(context: context, builder:(context)=> ContentDialog(content: Text("please select one file to continue"),actions: [Button(child: Text("Okay"), onPressed: (){Navigator.pop(context);})],));
              }
              },
              currentStep: state.currentIndex,
              type: material.StepperType.horizontal,
              steps:  [
                material.Step(
                    isActive: state.currentIndex == 0,
                    title: Text("Import Excel file"),
                    content: ImportExcelStep()),
                material.Step(
                    isActive: state.currentIndex == 1,
                    title: Text("Set data columns and rows"),
                    content:SetSheetColsAndRows()),
                material.Step(
                    isActive: state.currentIndex == 2,
                    title: Text("Import Excel file"),
                    content: Column(
                      children: [
                        Text(
                            "Please add excel file with extension .csv or with .xlsx")
                      ],
                    ))
              ]);
        },
      ),
    ));
  }
}
