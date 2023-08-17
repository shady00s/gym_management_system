import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_status/player_status_widget.dart';

import '../../../../database_management/tables/generate_table.dart';
import '../../../../database_management/tables/players/player_database_manager.dart';
import '../../combo_box_widget.dart';
import '../player_name_widget.dart';

class ActivePlayersWidget extends StatelessWidget {
  const ActivePlayersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // number
        Consumer(
          builder: (key, ref, child) {
            var list =
            ref.watch(activePlayersDurationProviderListLength);

            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: SizedBox(
                  width: 230,
                  height: 110,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(list.toString(),
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500)),
                      Text("Total active players")
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // filter


                Expander(header: Text("Filter by"), content: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                     const Text("Not selected")
                    ],)
                ],)),



        // list

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer(builder: (key, ref, child) {
              var playersListLength = ref.read(
                  activePlayersDurationProviderListLength.notifier);
              return FutureBuilder<List<Player>>(
                  future: PlayersDatabaseManager()
                      .getActivePlayersSubscriptions(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Future.delayed(
                                    const Duration(seconds: 0), () {
                                  playersListLength.state =
                                      snapshot.data!.length;
                                });

                                return PlayerNameWidget(
                                  snapshot
                                      .data![index].playerName,
                                  snapshot.data![index].playerId,
                                  snapshot.data![index].playerIndexId,
                                );
                              });
                        }
                        Future.delayed(const Duration(seconds: 0),
                                () {
                              playersListLength.state =
                                  snapshot.data!.length;
                            });
                        return Center(
                          child: Text("No new players"),
                        );
                      default:
                        return Center(
                          child: ProgressRing(),
                        );
                    }
                  });
            }),
          ),
        ),
      ],
    );
  }
}
