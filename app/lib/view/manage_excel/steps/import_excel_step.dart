
import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/manage_excel/cubit/cubit.dart';

class ImportExcelStep extends StatefulWidget {
  const ImportExcelStep({super.key});

  @override
  State<ImportExcelStep> createState() => _ImportExcelStepState();
}

class _ImportExcelStepState extends State<ImportExcelStep> {
  File? selectedFile;
  dynamic fileDetails;
  bool fileErr = false;
  @override
  Widget build(BuildContext context) {
     return Card(
       backgroundColor: Colors.black,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const  Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text("Please add excel file with extension .csv or with .xlsx"),
              ),
              DropTarget(
                  onDragDone: (details){

                    setState(() {
                      fileDetails = details.files[0];

                      selectedFile = File(details.files[0].path) ;
                    });
                   ExcelFileCubit.get(context).selectFile(PlatformFile(path:details.files[0].path,name: fileDetails.name, size: 0));

                  },
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    height: MediaQuery.sizeOf(context).height * 0.43,
                    child:  Card(child:  Center(
                      child:Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        selectedFile == null? SizedBox(child: Column(children: [
                            Icon(FluentIcons.file_template,color: Colors.grey[90],size: 26,),
                            const SizedBox(height: 12,),

                            Text( "Drag and Drop file",style: TextStyle(color: Colors.grey[90]),),

                            const SizedBox(height:20,),
                            const SizedBox(width:200,child:
                            Row(
                              mainAxisSize:MainAxisSize.min,
                              children: [
                                DecoratedBox(decoration: BoxDecoration(color: Colors.grey,),child: SizedBox(height: 1,width: 70,),)
                                ,
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("OR"),
                                ),
                                DecoratedBox(decoration: BoxDecoration(color: Colors.grey,),child: SizedBox(height: 1,width: 70,),)
                              ],) ,),
                            const SizedBox(height:20,),

                          ],),): SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.32,
                          child: Column(
                            children: [

                            Icon(FluentIcons.file_comment,color: Colors.grey[30],size: 85,),
                              const SizedBox(height: 20,),

                              Row(
                              children: [
                              const Text("Name: "),
                                const SizedBox(width: 60,),

                                Text(fileDetails?.name??"",),
                            ],),
                            const SizedBox(height: 20,),
                            Row(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              const Text("Path: "),
                                const SizedBox(width: 60,),

                                SizedBox(width: 290,child: Text(selectedFile?.path??"",)),
                            ],),
                            const SizedBox(height: 20,),


                          ],),
                        ),
                          const SizedBox(height: 20,),

                          Row(
                            mainAxisSize:MainAxisSize.min,
                            children: [
                              Text(fileDetails?.name??"Choose Excel file"),
                              const SizedBox(width: 12,),
                              const SizedBox(width: 12,),
                              Button(child: Text(selectedFile== null? "Select file":"Change file"), onPressed: ()async{
                                await FilePicker.platform.pickFiles(
                                   type: FileType.custom ,
                                    allowMultiple:false,allowedExtensions: ["csv","xlsx"]).then((value) {
                                      setState(() {
                                        fileDetails =value!.files[0];
                                        selectedFile = File(value.files[0].path!) ;
                                      });
                                      ExcelFileCubit.get(context).selectFile(PlatformFile(path:value!.files[0].path,name: fileDetails.name, size: 0));

                                }).catchError((err){
                                    print(err);
                                });
                              })
                            ],)
                        ],
                      ),)),
                  ))



            ],
          ),
     );
  }
}
