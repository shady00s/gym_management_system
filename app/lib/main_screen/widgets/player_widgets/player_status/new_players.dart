import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_status/player_status_widget.dart';

import '../../../../database_management/tables/generate_table.dart';
import '../../../../database_management/tables/players/player_database_manager.dart';
import '../player_name_widget.dart';
import 'filter_widget.dart';




class NewPlayersWidget extends StatelessWidget {
  const NewPlayersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        // number widget
        Consumer(
          builder: (key, ref, child) {
            var list =
            ref.watch(newPlayersAddedDurationProviderLength);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 230,
                height: 140,
                child: Card(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(list.toString(),
                          style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500)),
                      Text("New players  ")
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // filter widget


        FilterWidget(provider: filterNewProvider,),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer(builder: (key, ref, child) {
             var filterData =
              ref.watch(filterNewProvider);
              StateController<int> playersListLength = ref.read(
                  newPlayersAddedDurationProviderLength.notifier);
              return FutureBuilder<List<Player>>(
                  future: PlayersDatabaseManager()
                      .getNewPlayersSubscriptions(filterData),
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
                                    snapshot.data![index].playerIndexId

                                );
                              });
                        }

                        Future.delayed(const Duration(seconds: 0),
                                () {
                              playersListLength.state = 0;
                            });
                        return const Center(
                          child: Text("No new players"),
                        );

                      default:
                        return const Center(
                          child: ProgressRing(),
                        );
                    }
                  });
            }),
          ),
        ),

        SizedBox(width: 22),
      ],
    );
  }
}



