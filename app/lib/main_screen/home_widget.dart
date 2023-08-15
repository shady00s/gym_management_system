import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/database_management/tables/teams/teams_database_manager.dart';
import 'package:gym_management/main_screen/widgets/cards_with_icons.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/add_new_player.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/onboard_players.dart';
import 'package:gym_management/main_screen/widgets/search_widgets/search_widget.dart';

import '../database_management/tables/generate_table.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: Color.fromRGBO(12, 12, 12, 0.85),
      child: FutureBuilder<List<TeamsDataTableData>>(
        future: TeamsDatabaseManager().getAllTeams(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
              if(snapshot.hasData && snapshot.data!.isNotEmpty){
                return TabView(
                    onNewPressed: (){},
                    currentIndex: currentIndex,
                    onChanged: (val){
                      setState(() {
                        currentIndex = val;
                      });
                    },
                    tabs: snapshot.data!.map((e) =>
                        Tab(text:Text(e.teamName) ,closeIcon: null, body:  HomeTabWidget(teamId: e.teamId,))).toList());

              }else{
                return Center(child: Text("No Teams Found"),);
              }
            case ConnectionState.waiting:
              return Center(child: ProgressBar(),);
            default:
              return Center(child: ProgressBar(),);

          }
        }
      ),
    );
  }
}


class HomeTabWidget extends StatelessWidget {
  final int teamId;
  const HomeTabWidget({super.key,required this.teamId});

  @override
  Widget build(BuildContext context) {
    return   Card(
      backgroundColor: Colors.black,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 2,
                child:Center(child: Text("No Players added")) ),//OnBoardPlayers(title: "Active players for today:")),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(flex: 4, child: SearchWidget(teamId: teamId,)),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Quick access"),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child:SizedBox(width:700, child:     Wrap(

                        children: [
                          CardsWithIcon(
                            title: 'Re-new subscription',
                            icon: FluentIcons.refresh, onTap: (){},
                          ),
                          CardsWithIcon(
                              title: 'Show price list',
                              icon: FluentIcons.list, onTap: (){},),
                          CardsWithIcon(
                              title: 'Add new player',
                              icon: FluentIcons.add_friend, onTap: () async{
                                await showDialog(context: context, builder: (context)=>const AddNewPlayerWidget());
                          },),
                        ],
                      ),)

                  )
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: OnBoardPlayers(title: "Players need to subscribe:", data: PlayersDatabaseManager().getNeedToResubscribePlayersSubscriptions(teamId),)),
          ],
        ),
    );
  }
}


