import "package:fluent_ui/fluent_ui.dart";
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/player_name_widget.dart';

import '../../database_management/tables/generate_table.dart';
class PlayersListWidget extends StatelessWidget {
  final int teamId;
  PlayersListWidget({super.key,required this.teamId});

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
        future: PlayersDatabaseManager().getPlayersByTeam(teamId),
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
                        return PlayerNameWidget(playersList[index].playerName, playersList[index].playerId, playersList[index].playerIndexId );
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
