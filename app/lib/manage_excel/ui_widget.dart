
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
      child: BlocBuilder<ExcelFileCubit, ImportExcelState>(

        builder: (context, currentState) {
          ExcelFileCubit state = ExcelFileCubit.get(context);
          Future loadingDialog(context ,newNumber,function)async{

            int? status;
            await Future.delayed(const Duration(seconds: 0),() {


              function.then((value)async {
                status = value;
                if(status == 200){
                  state.incrementNumber(newNumber+1);

                }else{
                  await showDialog(context:context,  builder:(context){

                    return  ContentDialog(
                      actions: [
                        Button(child: const Text("CLose"), onPressed: (){
                          Navigator.pop(context);
                        })
                      ],
                      content:const Text("Error occured"),);
                  },

                  );
                }


              });
            });
            await showDialog(context:context,  builder:(context){
              Future.delayed(const Duration(seconds: 1),(){
                if(status !=null){
                  Navigator.pop(context);
                }
              });

              return const ContentDialog(content: ProgressBar(),);
            }
            );
          }
          int newIndex = state.currentIndex;
          int newNumber = newIndex;
          return material.Stepper(
        controlsBuilder: (context,details){
          if(state is LoadingState){
            return Padding(
              padding: const EdgeInsets.all(8.0),

              child: Row(children: [

                ProgressRing() ,
                SizedBox( width: 14,),
                Button(onPressed: details.onStepCancel,
                  child: Text("Cancel"),)
              ],),
            );
          }
          else{
            return Padding(

              padding: const EdgeInsets.all(8.0),

              child: Row(children: [

                FilledButton(onPressed:details.onStepContinue,
                  child: Text("Continue"),),
                SizedBox( width: 14,),
                Button(onPressed: details.onStepCancel,
                  child: Text("Cancel"),)
              ],),
            );
          }
        },
            onStepTapped: (index){


              state.incrementNumber(index);
            },
              onStepContinue:() async{
              if(state.excelFile !=null && state.currentIndex == 0 && state.listOfSheets.isEmpty){

              await  loadingDialog(context ,newNumber,ExcelFileCubit.get(context).sendFileToServer());
              }else if(state.excelFile ==null){
                material.showDialog(context: context, builder:(context)=> ContentDialog(content: Text("please select one file to continue"),actions: [Button(child: Text("Okay"), onPressed: (){Navigator.pop(context);})],));
              }

              else if(state.selectedList.isNotEmpty){
                await  loadingDialog(context ,newNumber,ExcelFileCubit.get(context).sendSelectedSheets());
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



