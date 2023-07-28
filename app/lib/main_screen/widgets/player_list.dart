import "package:fluent_ui/fluent_ui.dart";
import "package:gym_management/database_management/player_database_manager.dart";
import 'package:gym_management/main_screen/widgets/player_name_widget.dart';

import "../../database_management/tables/players_table.dart";
class PlayersListWidget extends StatelessWidget {
  PlayersListWidget({super.key});

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
        future: PlayersDatabaseManager().getPlayersData(),
        builder: (context, snapshot) {

          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: ProgressRing(),);

            case ConnectionState.done:
              if(snapshot.hasData){
                List<Player> playersList = snapshot.data!;
                return CustomScrollView(
                  shrinkWrap: false,
                  physics: const AlwaysScrollableScrollPhysics (),
                  slivers: [
                    SliverFixedExtentList(

                        delegate: SliverChildBuilderDelegate((context, index){
                        return PlayerNameWidget("${playersList[index].playerName}", playersList[index].playerId );
                    }
                    ,childCount: playersList.length,
                    ), itemExtent:70 )
                  ],
                ) ;
              }else{
                return Center(child: Text("No data found"),);
              }


            default:
              return Center(child: ProgressBar(),);
          }

        }
      );
  }
}
