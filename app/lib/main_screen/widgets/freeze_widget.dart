
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/manage_excel/ui_widget.dart';
import 'package:intl/intl.dart';

import '../../database_management/tables/generate_table.dart';
import '../../database_management/tables/players/player_database_manager.dart';

Future showFreezeWidget(context,playerIndexId)async{
  await showGeneralDialog(context: context, pageBuilder: (context,animation,animation2)=> FreezeWidget(playerIndexId: playerIndexId));
}
DateTime? customDate;
DateTime _beginningDate = DateTime.now();
TextEditingController? _beginDateController;
DateTime? customEndDate;
DateTime _endDate = DateTime.now();
TextEditingController? _endDateController;


class FreezeWidget extends StatelessWidget {
  final int playerIndexId;
  const FreezeWidget({super.key,required this.playerIndexId});

  @override
  Widget build(BuildContext context) {
    return  Center(child: SizedBox(
    width: 420,
    height: 380,
    child: Card(backgroundColor:Colors.black ,child: Column(
    children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text("Freeze",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.yellow),),
    IconButton(icon: const Icon(FluentIcons.cancel), onPressed: (){
    Navigator.pop(context);
    })
    ],),
    ),
    FutureBuilder<GetRemainingFreezeResult>(
    future: PlayersDatabaseManager().getFreeze(playerIndexId),
    builder: (context, snapshot) {

    switch (snapshot.connectionState){

    case ConnectionState.waiting:
    return const Expanded(child:  Center(child: ProgressRing(),));
    case ConnectionState.done:
    if(snapshot.data != null ){
    if(snapshot.data!.freezeAvailable == 0){
    return Expanded(child: Center(child:  Card(backgroundColor: Colors.red,child:const Text("This player has no freeze left"))));
    }
    return Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
    // gym player invitation id
    Padding(
    padding:  const EdgeInsets.all(8.0),
    child: Card(
    child:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    const Text("Player available freeze:"),
    Row(
      children: [
        Text(snapshot.data!.freezeAvailable.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize:18),),
        Text(" Days"),
      ],
    )
    ],
    ),
    ),
    ),

    // guest information
    const SizedBox(height: 20,),
// select beginning custom date
    StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      if(_beginDateController == null) {
        setState((){
          _beginDateController = TextEditingController();
        _beginDateController!.text =  DateFormat.yMMMEd().format(DateTime.now());

      });
      }
      if(_endDateController == null) {
        setState((){
          _endDateController = TextEditingController();
          _endDateController!.text =  DateFormat.yMMMEd().format(DateTime.now().add(Duration(days: snapshot.data!.freezeAvailable)));

        });
      }
      submitFunction(){
        setState(() {
          _beginDateController?.text =  DateFormat.yMMMEd().format(customDate!);
          _beginningDate = customDate!;
          _endDateController!.text = DateFormat.yMMMEd().format(customDate!.add(Duration(days: snapshot.data!.freezeAvailable)));
        });
        Navigator.pop(context);

      }
      cancelFunction(){
        Navigator.pop(context);
      }
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Freeze beginning date:"),
          ),

          TextFormBox(

            onTap: ()async{
              await showDialog(context: context, builder:(context)=> StatefulBuilder(

                  builder: (context, setState) {
                    return ContentDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const  Text("Select custom date"),
                          IconButton(icon:const Icon(FluentIcons.cancel),onPressed:(){Navigator.pop(context);})
                        ],), content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("NOTE: system cannot accept old date"),
                        const  SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DatePicker(showYear:  false, startDate: DateTime.now(), selected: customDate,onChanged: (val){
                            setState(() {
                              customDate = val;
                            });
                          },),
                        ),
                        if( customDate!= null && customDate!.difference(DateTime.now()).inDays.isNegative )
                          Text("please select newer date",style: TextStyle(color: Colors.red,fontSize: 19),),
                      ],
                    )
                      , actions:customDate!= null && !customDate!.difference(DateTime.now()).inDays.isNegative? [
                      FilledButton(onPressed:submitFunction, child:  const Text("submit")),
                      Button(onPressed:cancelFunction, child: const Text("cancel")),

                    ]:null,

                    );
                  }
              ) ) ;
            },
            readOnly: true,
            controller: _beginDateController,),

      const SizedBox(height: 20,),
      // select end custom date
      const  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Freeze end date:"),
      ),



        TextFormBox(
      readOnly: true,
      controller: _endDateController,),
          SizedBox(height: 40,),
          Center(child: FilledButton(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Submit freeze"),
          ), onPressed: ()async{
            
            await loadingDialog(context, -1, PlayersDatabaseManager().freezePlayerSubscription(snapshot.data!.subId!, _beginningDate, _endDate,snapshot.data!.freezeAvailable,snapshot.data!.endDate), null);
          }))
      ],
      );

    },),




    ],),
    );

    }

    return Center(child: Text("Error occured"),);
    default:
    return const Center(child: ProgressRing(),);
    }

    }
    ),
    ],
    ),),
    ));
  }
}
