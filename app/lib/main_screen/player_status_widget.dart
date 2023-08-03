import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/player_name_widget.dart';

import '../database_management/tables/players_table.dart';

class PlayerStatusWidget extends StatelessWidget {
  const PlayerStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const  Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Status",style: TextStyle(fontSize: 31,fontWeight: FontWeight.w800),),
        ),
       Expanded(
         flex: 1,
         child: const Row(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                Text("21"),
                Text("New players")
              ],),),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text("21"),
                Text("players with ended subscription")
              ],),),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                Text("21"),
                Text("Total active players")
              ],),),
              ),
            ),
          ],),
       ),

        Expanded(
          flex:5,
          child: Row(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FutureBuilder<List<Player>>(
                  future: PlayersDatabaseManager().getNewPlayersSubscriptions(),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState){
                      case ConnectionState.done:
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context,index)=>PlayerNameWidget(snapshot.data![index].playerName, snapshot.data![index].playerId),);

                        }
                        return Center(child: Text("No new players"),);
                      default:
                        return Center(child: ProgressRing(),);
                    }
                  }
                ),),
              ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FutureBuilder<List<Player>>(
    future: PlayersDatabaseManager().getEndedSubscriptionsPlayers(),
    builder: (context, snapshot) {
    switch(snapshot.connectionState){
    case ConnectionState.done:
    if(snapshot.hasData){
    return ListView.builder(
    itemCount: snapshot.data!.length,
    itemBuilder: (context,index)=>PlayerNameWidget(snapshot.data![index].playerName, snapshot.data![index].playerId),);

    }
    return Center(child: Text("No new players"),);
    default:
    return Center(child: ProgressRing(),);
    }
    }
    ),
            ),),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder( itemBuilder: (context,index)=>PlayerNameWidget("test", 1),),),
            ),
          ],),
        )
      ],
    );
  }
}
