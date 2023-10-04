import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/gym_player_logs/gym_log_manager.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/database_management/tables/teams/teams_database_manager.dart';
import 'package:gym_management/view/main_screen.dart';
import 'package:gym_management/view/widgets/cards_with_icons.dart';
import 'package:gym_management/view/widgets/enter_players_manually.dart';
import 'package:gym_management/view/widgets/player_widgets/add_new_player.dart';
import 'package:gym_management/view/widgets/player_widgets/onboard_players.dart';
import 'package:gym_management/view/widgets/player_widgets/player_name_with_image_widget.dart';
import 'package:gym_management/view/widgets/price_list_widget.dart';
import 'package:gym_management/view/widgets/search_widgets/search_widget.dart';

import '../database_management/tables/generate_table.dart';
import 'widgets/add_new_team_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}
Future<List<TeamsDataTableData>> getAllData() async {
  return TeamsDatabaseManager().getAllTeams();
}
class _HomeWidgetState extends State<HomeWidget> {
  late Future<List<TeamsDataTableData>> fetchData;
  int currentIndex = 0;

  @override
  void initState() {
    fetchData = getAllData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: const Color.fromRGBO(12, 12, 12, 0.85),
      child: FutureBuilder<List<TeamsDataTableData>>(
          future: fetchData,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return TabView(
                      onNewPressed: () async{
                 await showAddNewTeamWidget(context);
                  },
                      currentIndex: currentIndex,
                      onChanged: (val) {
                        setState(() {
                          currentIndex = val;
                        });
                      },
                      tabs: snapshot.data!
                          .map((e) => Tab(
                              text: Text(e.teamName),
                              closeIcon: null,
                              body: HomeTabWidget(
                                teamId: e.teamId,
                              )))
                          .toList());
                } else {
                  return  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FluentIcons.teamwork,size: 41,color: Colors.grey[80],),
                      const SizedBox(height: 21,),
                      const Text("No Teams Found",style: TextStyle(fontSize: 19),),
                      const SizedBox(height: 10,),

                      Text("please choose to import data from excel or create new team instead",style: TextStyle(color: Colors.grey[80]),),
                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Consumer(

                              builder: (context, ref,child) {
                                var setCurrentIndex = ref.read(navigationProvider.notifier);

                                return Button(child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(FluentIcons.excel_document),
                                    ),

                                    Text("Import data from excel file"),
                                  ],
                                ), onPressed: (){
                                  setCurrentIndex.state = 4;
                                  });
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(FluentIcons.people_add),
                                ),

                                Text("Create new team"),
                              ],
                            ), onPressed: () async{await showAddNewTeamWidget(context);}),
                          ),
                        ],
                      )
                    ],
                  );
                }
              case ConnectionState.waiting:
                return const Center(
                  child: ProgressBar(),
                );
              default:
                return const SizedBox();
            }
          }),
    );
  }
}

var getPlayerTeamProvider = StateProvider((ref) => 0);
var getPlayerLogsProvider = FutureProvider((ref) => GymLogsManager().getTodayPlayers(ref.watch(getPlayerTeamProvider)));

class HomeTabWidget extends StatelessWidget {
  final int teamId;
  const HomeTabWidget({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  EnterPlayersManually(teamId: teamId),
                  // players log widget
                  Expanded(child: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      var teamIdProvider =
                          ref.read(getPlayerTeamProvider.notifier);
                      var logsList = ref.watch(getPlayerLogsProvider);
                      Future.delayed(Duration.zero, () {
                        teamIdProvider.state = teamId;
                      });

                      return logsList.when(
                          data: (data) => data.isNotEmpty
                              ? ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return PlayerNameWithImage(
                                        playerName: data[index].playerName,
                                        playerId: data[index].playerId,
                                        imagePath: data[index].imagePath,
                                        playerIndexId:
                                            data[index].playerIndexId);
                                  })
                              : const Center(
                                  child: Text("No Data found"),
                                ),
                          error: (error, stats) =>
                              Text("Error occurred $error"),
                          loading: () => const Center(
                                child: ProgressRing(),
                              ));
                    },
                  ))
                ],
              )),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(
                    flex: 4,
                    child: SearchWidget(
                      teamId: teamId,
                    )),
                const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Quick access"),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 700,
                      child: Wrap(
                        children: [
                          CardsWithIcon(
                            title: 'Show price list',
                            icon: FluentIcons.list,
                            onTap: () async{await showPriceListWidget(context);},
                          ),
                          CardsWithIcon(
                            title: 'Add new player',
                            icon: FluentIcons.add_friend,
                            onTap: () async {
                              await showGeneralDialog(
                                  context: context,
                                  pageBuilder:
                                      (context, animation, animation2) =>
                                          const AddNewPlayerWidget());
                            },
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
              flex:4,
              child: OnBoardPlayers(
                title: "Players need to subscribe:",
                data: PlayersDatabaseManager()
                    .getNeedToResubscribePlayersSubscriptions(teamId),
              )),
        ],
      ),
    );
  }
}
