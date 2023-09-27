import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/gym_player_logs/gym_log_manager.dart';
import 'package:gym_management/database_management/tables/teams/teams_database_manager.dart';
import 'package:gym_management/view/widgets/player_widgets/player_name_with_image_widget.dart';
import 'package:intl/intl.dart';

import '../../database_management/tables/generate_table.dart';

class TimeModel {
  int day;
  int month;
  int year;
  TimeModel({required this.day, required this.month, required this.year});
}

var playersLogProvider = StateProvider<TimeModel>((ref) => TimeModel(
    day: DateTime.now().day,
    month: DateTime.now().month,
    year: DateTime.now().year));
var selectedTeamId = StateProvider<int?>((ref) => null);
var selectedTeam = StateProvider<TeamsDataTableData?>((ref) => null);
var getPlayersProvider = FutureProvider<List<GetListOfPlayersLogsResult>>(
    (ref) => GymLogsManager().getListOfPlayersLogs(
        ref.watch(selectedTeamId),
        DateTime(
            ref.watch(playersLogProvider).year,
            ref.watch(playersLogProvider).month,
            ref.watch(playersLogProvider).day,
            01,
            0,
            0)));
var getTeamsProvider = FutureProvider<List<TeamsDataTableData>>(
    (ref) => TeamsDatabaseManager().getAllTeams());

class PlayersLogsWidget extends StatelessWidget {
  const PlayersLogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: Colors.black,
      child: Consumer(builder: (context, ref, child) {
        var getDateValue = ref.watch(playersLogProvider);
        var setDateValue = ref.read(playersLogProvider.notifier);
        var getPlayers = ref.watch(getPlayersProvider);
        var getTeam = ref.watch(selectedTeam);
        var setTeam = ref.read(selectedTeam.notifier);
        var setTeamId = ref.read(selectedTeamId.notifier);
        var getTeams = ref.watch(getTeamsProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Players logs",
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Select Date"),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                    width: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Day"),
                        NumberFormBox(
                          mode: SpinButtonPlacementMode.none,
                          value: getDateValue.day,
                          onChanged: (val) {
                            setDateValue.state = TimeModel(
                              day: val!,
                              month: getDateValue.month,
                              year: getDateValue.year,
                            );
                          },
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                    width: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Month"),
                        NumberFormBox(
                            mode: SpinButtonPlacementMode.none,
                            value: getDateValue.month,
                            onChanged: (val) {
                              setDateValue.state = TimeModel(
                                day: getDateValue.day,
                                month: val!,
                                year: getDateValue.year,
                              );
                            }),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                    width: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Year"),
                        NumberFormBox(
                            mode: SpinButtonPlacementMode.none,
                            value: getDateValue.year,
                            onChanged: (val3) {
                              setDateValue.state = TimeModel(
                                  day: getDateValue.day,
                                  month: getDateValue.month,
                                  year: val3!);
                            }),
                      ],
                    )),
              ),
              getTeams.when(
                  data: (data) =>  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Team"),
                            ComboBox(
                                value: getTeam,
                                onChanged: (val) {
                                  setTeamId.state = val?.teamId;
                                  setTeam.state = val;
                                },
                                items: [
                                  const ComboBoxItem(
                                      value: null, child: Text("All Teams")),
                                  ...data
                                      .map((e) => ComboBoxItem(
                                          value: e, child: Text(e.teamName)))
                                      .toList()
                                ]),
                          ],
                        ),
                      ) ,
                  error: (err, state) => const Text("error"),
                  loading: () => const Center(
                        child: ProgressBar(),
                      ))
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: getPlayers.when(data: (data) => data.isNotEmpty? Wrap(children:data.map((e) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: SizedBox(
                        width: 330,
                        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerNameWithImage(
                playerName: e.playerName,
                playerId: e.playerId,
                imagePath: e.imagePath,
                playerIndexId: e.playerIndexId),
                Row(children: [
                    const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Icon(FluentIcons.timer),
                    ),
                    Text(DateFormat.Hms().format(e.playerEntranceDate) )

                ],)
              ],
          ),
                      ),
                    ),
                  ))
              .toList(),)   :Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,children: [
                    const SizedBox(height: 59,),

                    Icon(FluentIcons.profile_search,size: 51,color: Colors.grey[80],),
                    const SizedBox(height: 9,),
                    const Text("No players found on this day")
                  ],)   , error: (err, state) => const Text("error"), loading: ()=>const Center(
        child: ProgressRing(),) )


    ),
            )
          ],
        );
      }),
    );
  }
}
