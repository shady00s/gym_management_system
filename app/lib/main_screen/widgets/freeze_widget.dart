
import 'package:fluent_ui/fluent_ui.dart';

import '../../database_management/tables/generate_table.dart';
import '../../database_management/tables/players/player_database_manager.dart';

Future showFreezeWidget(context,playerIndexId)async{
  await showGeneralDialog(context: context, pageBuilder: (context,animation,animation2)=> FreezeWidget(playerIndexId: playerIndexId));
}
class FreezeWidget extends StatelessWidget {
  final int playerIndexId;
  const FreezeWidget({super.key,required this.playerIndexId});

  @override
  Widget build(BuildContext context) {
    return  Center(child: SizedBox(
    width: 420,
    height: MediaQuery.sizeOf(context).width * 0.9,
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
    child: Column(children: [
    // gym player invitation id
    Padding(
    padding:  const EdgeInsets.all(8.0),
    child: Card(
    child:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    const Text("Player available freeze:"),
    Text(snapshot.data!.freezeAvailable.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize:18),)
    ],
    ),
    ),
    ),

    // guest information
    const SizedBox(height: 20,),

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
