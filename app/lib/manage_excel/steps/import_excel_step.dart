
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
  PlatformFile? selectedFile;
  bool fileErr = false;
  @override
  Widget build(BuildContext context) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Please add excel file with extension .csv or with .xlsx"),
            ),
            DropTarget(

                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.95,
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child:  Card(child:  Center(
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      selectedFile == null? SizedBox(child: Column(children: [
                          Icon(FluentIcons.file_template,color: Colors.grey[90],),
                          SizedBox(height: 12,),

                          Text( "Drag and Drop file",style: TextStyle(color: Colors.grey[90]),),

                          SizedBox(height:20,),
                          SizedBox(width:200,child:
                          Row(
                            mainAxisSize:MainAxisSize.min,
                            children: [
                              DecoratedBox(decoration: BoxDecoration(color: Colors.grey,),child: SizedBox(height: 1,width: 70,),)
                              ,
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("OR"),
                              ),
                              DecoratedBox(decoration: BoxDecoration(color: Colors.grey,),child: SizedBox(height: 1,width: 70,),)
                            ],) ,),
                          SizedBox(height:20,),

                        ],),): SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.32,
                        child: Column(
                          children: [

                          Icon(FluentIcons.file_comment,color: Colors.grey[30],size: 85,),
                            SizedBox(height: 20,),

                            Row(
                            children: [
                            Text("Name: "),
                              SizedBox(width: 60,),

                              Text(selectedFile?.name??"",),
                          ],),
                          SizedBox(height: 20,),
                          Row(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text("Path: "),
                              SizedBox(width: 60,),

                              SizedBox(width: 290,child: Text(selectedFile?.path??"",)),
                          ],),
                          SizedBox(height: 20,),

                          Row(
                            children: [
                            Text("Size: "),
                              SizedBox(width: 60,),
                              Text(selectedFile?.size.toString()??"" " KB"),
                          ],),
                        ],),
                      ),
                        SizedBox(height: 20,),

                        Row(
                          mainAxisSize:MainAxisSize.min,
                          children: [
                            Text(selectedFile?.name??"Choose Excel file"),
                            SizedBox(width: 12,),
                            SizedBox(width: 12,),
                            Button(child: Text(selectedFile== null? "Select file":"Change file"), onPressed: ()async{
                              await FilePicker.platform.pickFiles(
                                 type: FileType.custom ,
                                  allowMultiple:false,allowedExtensions: ["csv","xlsx"]).then((value) {
                                    setState(() {
                                      selectedFile = value!.files[0];
                                      ExcelFileCubit.get(context).selectFile(File(value!.files[0].path!));
                                    });
                              }).catchError((err){
                                  print(err);
                              });
                            })
                          ],)
                      ],
                    ),)),
                ))



          ],
        );
  }
}
