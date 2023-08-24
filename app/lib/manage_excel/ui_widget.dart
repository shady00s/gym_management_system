
import "package:fluent_ui/fluent_ui.dart";
import "package:flutter/material.dart" as material;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gym_management/manage_excel/cubit/state.dart";
import "package:gym_management/manage_excel/steps/finish_data.dart";
import "package:gym_management/manage_excel/steps/import_excel_step.dart";
import "package:gym_management/manage_excel/steps/set_cols_rows.dart";

import "cubit/cubit.dart";

class ImportExcelScreen extends StatelessWidget {
  const ImportExcelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      backgroundColor: Colors.black,
      child: ScaffoldPage(
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Setting Data",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold ,fontSize: 21 ),),
      ),
      content: const Padding(padding: EdgeInsets.all(14), child: StepsWidget())) ,
    );
  }
}
Future loadingDialog(context ,newNumber,function,state)async{
  int? status;
  await showDialog(context:context,  builder:(context){
    Future.delayed( Duration.zero,() async{

      await function.then((value)async {
        status = value;
        if(status == 200){

          state.incrementNumber(newNumber+1);
          Navigator.pop(context);
        }else{
          Navigator.pop(context);
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

    return const ContentDialog(content: ProgressBar(),);
  }
  );
}
class StepsWidget extends StatefulWidget {
  const StepsWidget({super.key});

  @override
  State<StepsWidget> createState() => _StepsWidgetState();
}

class _StepsWidgetState extends State<StepsWidget> {

  @override
  Widget build(BuildContext context) {
    return
        Card(
    backgroundColor: Colors.black,
    child: material.Scaffold( body:BlocProvider<ExcelFileCubit>(
          create: (context) => ExcelFileCubit(),
          child: BlocBuilder<ExcelFileCubit, ImportExcelState>(

            builder: (context, currentState) {
              ExcelFileCubit state = ExcelFileCubit.get(context);

              int newIndex = state.currentIndex;
              int newNumber = newIndex;
              return material.Stepper(
                  controlsBuilder: (context,details){
                    if(state is LoadingState){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Row(children: [

                          const   ProgressRing() ,
                          const  SizedBox( width: 14,),
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

                      await  loadingDialog(context ,newNumber,ExcelFileCubit.get(context).sendFileToServer(),state);
                    }else if(state.excelFile ==null){
                      material.showDialog(context: context, builder:(context)=> ContentDialog(content: Text("please select one file to continue"),actions: [Button(child: Text("Okay"), onPressed: (){Navigator.pop(context);})],));
                    }

                    else if(state.selectedList.isNotEmpty){
                      await  loadingDialog(context ,newNumber,ExcelFileCubit.get(context).sendSelectedSheets(),state);
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
                        title: const Text("Setting Teams and coaches"),
                        content:const SetSheetColsAndRows()),
                    material.Step(
                        isActive: state.currentIndex == 2,
                        title: const Text("Finish up"),
                        content:const FinishDataWidget()),

                  ]);
            },
          ),
        )),)

    ;
  }
}



