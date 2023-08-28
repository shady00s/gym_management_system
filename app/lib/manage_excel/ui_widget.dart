
import "package:fluent_ui/fluent_ui.dart";
import "package:flutter/material.dart" as material;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gym_management/manage_excel/cubit/state.dart";
import "package:gym_management/manage_excel/steps/coaches_data.dart";
import "package:gym_management/manage_excel/steps/finish_data.dart";
import "package:gym_management/manage_excel/steps/import_excel_step.dart";
import "package:gym_management/manage_excel/steps/set_sheets.dart";

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
  int? status = -1;
  await showDialog(context:context,  builder:(context){
    Future.delayed( Duration.zero,() async{

      await function.then((value)async {
        print(value);
        status = value;
        if(status == 200){

         newNumber!=-1 && state != null? state.incrementNumber(newNumber+1):null;
          Navigator.pop(context);
        }else if(status != null){
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
        else{
          Navigator.pop(context);
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
    child: material.Scaffold(
        body:BlocProvider<ExcelFileCubit>(
          create: (context) => ExcelFileCubit(),
          child: BlocBuilder<ExcelFileCubit, ImportExcelState>(

            builder: (context, currentState) {
              ExcelFileCubit state = ExcelFileCubit.get(context);

              int newIndex = state.currentIndex;
              int newNumber = newIndex;
              return material.Stepper(
                  onStepTapped: (int index) {
                    if (state.currentIndex != index) {
                      state.currentIndex = state.currentIndex;
                    }
                  },
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

                  onStepContinue:() async{
                    if(state.excelFile !=null && state.currentIndex == 0 ){

                      await  loadingDialog(context ,newNumber,ExcelFileCubit.get(context).sendFileToServer(),state);
                    }else if(state.excelFile ==null){
                      material.showDialog(context: context, builder:(context)=> ContentDialog(content: Text("please select one file to continue"),actions: [Button(child: Text("Okay"), onPressed: (){Navigator.pop(context);})],));
                    }

                    else if(state.selectedList.isNotEmpty && state.currentIndex == 1){
                      
                      await  loadingDialog(context ,newNumber,ExcelFileCubit.get(context).sendSelectedSheets(),state);
                    }

                    else if(state.currentIndex == 2)
                       {
                         if(!state.checkValidation()){
                           await showDialog(context: context, builder: (BuildContext context) {
                             return const ContentDialog(content: Text("Please fill the remaining  form"),);
                           }, );
                         }else{
                           state.incrementNumber(newNumber+1);
                         }

                      }



                  },

                  onStepCancel:state.currentIndex> 0?  (){

                    if(newIndex > 0){
                      print('tt');
                      state.decrementNumber(newIndex-1);
                    }
                  }:null,
                  currentStep: state.currentIndex,
                  type: material.StepperType.horizontal,
                  steps:  [
                    material.Step(
                        isActive: state.currentIndex == 0,
                        title: Text("Import Excel file"),
                        content: ImportExcelStep()),
                    material.Step(
                        isActive: state.currentIndex == 1,
                        title: const Text("Setting Teams"),
                        content:const SetSheetColsAndRows()),
                    material.Step(
                        isActive: state.currentIndex == 2,
                        title: const Text("Setting  coaches"),
                        content:const SetCoachesWidget()),
                    material.Step(
                        isActive: state.currentIndex == 3,
                        title: const Text("Finish up"),
                        content:const FinishDataWidget()),

                  ]);
            },
          ),
        )),)

    ;
  }
}



