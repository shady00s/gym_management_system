import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/gym_player_logs/gym_log_manager.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/database_management/tables/teams/teams_database_manager.dart';
import 'package:gym_management/view/widgets/cards_with_icons.dart';
import 'package:gym_management/view/widgets/enter_players_manually.dart';
import 'package:gym_management/view/widgets/player_widgets/add_new_player.dart';
import 'package:gym_management/view/widgets/player_widgets/onboard_players.dart';
import 'package:gym_management/view/widgets/player_widgets/player_name_with_image_widget.dart';
import 'package:gym_management/view/widgets/price_list_widget.dart';
import 'package:gym_management/view/widgets/search_widgets/search_widget.dart';

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
      backgroundColor: const Color.fromRGBO(12, 12, 12, 0.85),
      child: FutureBuilder<List<TeamsDataTableData>>(
          future: TeamsDatabaseManager().getAllTeams(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return TabView(
                      onNewPressed: () {},
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
                  return const Center(
                    child: Text("No Teams Found"),
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
var getPlayerLogsProvider = FutureProvider((ref) =>
    GymLogsManager().getTodayPlayers(ref.watch(getPlayerTeamProvider)));

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
              flex: 3,
              child: Column(
                children: [
                  EnterPlayersManually(teamId: teamId),
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
              )), //OnBoardPlayers(title: "Active players for today:")),
          Expanded(
            flex: 5,
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
              flex: 3,
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
