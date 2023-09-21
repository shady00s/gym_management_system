import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/view/widgets/player_widgets/player_status/filter_widget.dart';
import 'package:gym_management/view/widgets/player_widgets/player_status/player_status_widget.dart';
import '../../../../database_management/tables/generate_table.dart';
import '../../../../database_management/tables/players/player_database_manager.dart';
import '../player_name_widget.dart';

class EndedPlayersSubscriptionWidget extends StatelessWidget {
  const EndedPlayersSubscriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // number card
        Consumer(
          builder: (key, ref, child) {
            var list = ref.watch(endedPlayersDurationProviderListLength);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: SizedBox(
                  width: 230,
                  height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(list.toString(),
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.w500)),
                      const Text("players with ended subscription")
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // filter widget
        FilterWidget(
          provider: filterEndedProvider,
        ),

        // list
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer(builder: (key, ref, child) {
              var filter = ref.watch(filterEndedProvider);
              var playersListLength =
                  ref.read(endedPlayersDurationProviderListLength.notifier);
              return FutureBuilder<List<Player>>(
                  future: PlayersDatabaseManager()
                      .getEndedSubscriptionsPlayers(filter),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Future.delayed(const Duration(seconds: 0), () {
                                  playersListLength.state =
                                      snapshot.data!.length;
                                });

                                return PlayerNameWidget(
                                  snapshot.data![index].playerName,
                                  snapshot.data![index].playerId,
                                  snapshot.data![index].playerIndexId,
                                );
                              });
                        }

                        Future.delayed(const Duration(seconds: 0), () {
                          playersListLength.state = snapshot.data?.length ?? 0;
                        });
                        return const Center(
                          child: Text("No ended subscriptions players"),
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
        const SizedBox(width: 22),
      ],
    );
  }
}
