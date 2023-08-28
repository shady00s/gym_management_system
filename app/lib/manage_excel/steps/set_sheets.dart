import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/manage_excel/cubit/cubit.dart';
import 'package:gym_management/manage_excel/cubit/state.dart';
import 'package:gym_management/manage_excel/model/sheets_model.dart';

class SetSheetColsAndRows extends StatelessWidget {
  const SetSheetColsAndRows({super.key});
  @override
  Widget build(BuildContext context) {


    return  SizedBox(
      height: 360,
      width: 600,
      child: BlocConsumer<ExcelFileCubit,ImportExcelState>(builder: (BuildContext context, state) {
        List<SheetsModel> listOfSheets = ExcelFileCubit.get(context).listOfSheets;
        if(listOfSheets.isNotEmpty) {
         return  Column(
              children: [
                const Text("Select sheets"),

                TreeView(
                    selectionMode: TreeViewSelectionMode.multiple,
                    onSelectionChanged: (selectedItems) async
                    {
                      List<SheetsModel> selectedList = [];
                      for(var d in selectedItems ){
                        if( d.value.id != -1) {
                          selectedList.add(d.value);
                       }
                      }
                      ExcelFileCubit.get(context).setSelectedListOfSheets(selectedList);

                        },


                    items:[TreeViewItem(value: SheetsModel(id: -1,name: "all"), content: Text("Select all"),children: ExcelFileCubit.get(context).listOfSheets.map((e) =>  TreeViewItem( value: e, content: Text(e.name))).toList())]

                )
              ]
          );
        } else{
          return Center(child: Text("No sheets found"),);
        }

      }, listener: (BuildContext context, Object? state) {  },

      )
    )
    ;

  }
}
