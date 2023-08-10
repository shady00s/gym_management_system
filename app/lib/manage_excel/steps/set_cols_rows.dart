import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/manage_excel/cubit/cubit.dart';
import 'package:gym_management/manage_excel/model/sheets_model.dart';

class SetSheetColsAndRows extends StatelessWidget {
  const SetSheetColsAndRows({super.key});
  @override
  Widget build(BuildContext context) {
    List<SheetsModel> selectedList = ExcelFileCubit.get(context).selectedList;
    List<SheetsModel> listOfSheets = ExcelFileCubit.get(context).listOfSheets;

    return  SizedBox(
      height: 360,
      width: 600,
      child: Column(
        children: [
          const Text("Select sheets"),
            TreeView(
                selectionMode: TreeViewSelectionMode.multiple,
                onItemInvoked: (val,reason)async{
                  if(val.value.id == -1){
                    for (var data in listOfSheets ){
                      if( !selectedList.contains(data)){
                        selectedList.add(data);
                      }

                    }

                  }else{

                    if( !selectedList.contains(val.value)){
                      selectedList.add(val.value);
                    }
                    else{
                      int index = selectedList.indexOf(val.value);
                      selectedList.removeAt(index);
                    }

                  }


                  },
                items:[TreeViewItem(value: SheetsModel(id: -1,name: "all"), content: Text("Select all"),children: ExcelFileCubit.get(context).listOfSheets.map((e) =>  TreeViewItem( value: e, content: Text(e.name))).toList())]

          )
        ]
          )
    )
    ;

  }
}
