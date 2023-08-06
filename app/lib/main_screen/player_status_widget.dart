import 'dart:core';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/combo_box_widget.dart';
import 'package:gym_management/main_screen/widgets/player_name_widget.dart';

import '../database_management/tables/players_table.dart';

class DurationModel {
  final String title;
  final DateTime value;

  DurationModel(this.title, this.value);
}

class GenderModel {
  final String title;
  final String value;

  GenderModel(this.title, this.value);
}

List<DurationModel> durationList = [
  DurationModel("Today", DateTime.now()),
  DurationModel("Past 10 days", DateTime.now().subtract(Duration(days: 10))),
  DurationModel("Past 20 days", DateTime.now().subtract(Duration(days: 20))),
  DurationModel("Past 1 month", DateTime.now().subtract(Duration(days: 30))),
  DurationModel("Past 2 months", DateTime.now().subtract(Duration(days: 60))),
  DurationModel("Past 3 months", DateTime.now().subtract(Duration(days: 90))),
];
List<GenderModel> genders = [
  GenderModel("All", ""),
  GenderModel("Male", "Male"),
  GenderModel("Female", "Female"),
];

var newPlayersAddedDurationProvider =
    StateProvider<DateTime>((ref) => DateTime.now());
var newPlayersAddedDurationProviderLength = StateProvider<int>((ref) => 0);

var endedPlayersDurationProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

var endedPlayersDurationProviderListLength = StateProvider<int>((ref) => 0);

var activePlayersDurationProviderListLength = StateProvider<int>((ref) => 0);


var customEndSubscriptionDateProvider = StateProvider<CustomDateModel?>((ref) => null);

class PlayerStatusWidget extends StatelessWidget {
  const PlayerStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Status",
                  style: TextStyle(fontSize: 31, fontWeight: FontWeight.w600),
                ),
              ),

              // number card
              SizedBox(
                height: 160,
                width: MediaQuery.of(context).size.width * 0.98,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer(
                      builder: (key, ref, child) {
                        var list =
                            ref.watch(newPlayersAddedDurationProviderLength);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 250,
                            height: 250,
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
                    Consumer(
                      builder: (key, ref, child) {
                        var list =
                            ref.watch(endedPlayersDurationProviderListLength);

                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            child: SizedBox(
                              height: 200,
                              width: 200,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(list.toString(),
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w500)),
                                  Text("players with ended subscription")
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Consumer(
                      builder: (key, ref, child) {
                        var list =
                            ref.watch(activePlayersDurationProviderListLength);

                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            child: SizedBox(
                              height: 200,
                              width: 200,
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
                  ],
                ),
              ),

              // filter by widget
              SizedBox(
                height:100,
                width: MediaQuery.of(context).size.width * 0.98,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.end,
                            children: [
                              SizedBox( width:150,child: Text("Filter by")),

                              const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Coach"),
                                  ComboBox(items: [
                                    ComboBoxItem(
                                      value: 0,
                                      child: Text("All"),
                                    )
                                  ])
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Consumer(builder: (key, ref, child) {
                                final setDate = ref.read(
                                    newPlayersAddedDurationProvider.notifier);

                                return ComboBoxWidget(
                                  items: durationList,
                                  filterTitle: 'Duration',
                                  onChanged: (val) {
                                    setDate.state = val.value;
                                  },
                                );
                              }),
                              const SizedBox(
                                width: 8,
                              ),
                              ComboBoxWidget(
                                items: genders,
                                filterTitle: "Gender",
                                onChanged: (int val) {},
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 22),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.end,
                            children: [
                              SizedBox( width:150,child: Text("Filter by")),

                              const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Coach"),
                                  ComboBox(items: [
                                    ComboBoxItem(
                                      value: 0,
                                      child: Text("All"),
                                    )
                                  ])
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Consumer(builder: (key, ref, child) {
                                final setDate = ref.read(
                                    endedPlayersDurationProvider.notifier);

                                return ComboBoxWidget(
                                  items: durationList,
                                  filterTitle: 'Duration',
                                  onChanged: (val) {
                                    setDate.state = val.value;
                                  },
                                );
                              }),
                              const SizedBox(
                                width: 8,
                              ),
                              ComboBoxWidget(
                                items: genders,
                                filterTitle: "Gender",
                                onChanged: (int val) {},
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 22),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child:  Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.end,
                            children: [
                              SizedBox( width:250,child: Text("Filter by")),

                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Coach"),
                                  ComboBox(items: [
                                    ComboBoxItem(
                                      value: 0,
                                      child: Text("All"),
                                    )
                                  ])
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              ComboBoxWidget(
                                items: genders,
                                filterTitle: "Gender",
                                onChanged: (int val) {},
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // players list
              SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width * 0.96,

                child:    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer(builder: (key, ref, child) {
                          DateTime playersCount =
                          ref.watch(newPlayersAddedDurationProvider);
                          StateController<int> playersListLength = ref.read(
                              newPlayersAddedDurationProviderLength.notifier);
                          return FutureBuilder<List<Player>>(
                              future: PlayersDatabaseManager()
                                  .getNewPlayersSubscriptions(playersCount),
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
                                                snapshot.data![index].playerId);
                                          });
                                    }

                                    Future.delayed(const Duration(seconds: 0),
                                            () {
                                          playersListLength.state = 0;
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer(builder: (key, ref, child) {
                          DateTime playersCount =
                          ref.watch(endedPlayersDurationProvider);

                          var customDateTime = ref.watch(customEndSubscriptionDateProvider);
                          var playersListLength = ref.read(
                              endedPlayersDurationProviderListLength.notifier);
                          return FutureBuilder<List<Player>>(
                              future:customDateTime == null? PlayersDatabaseManager()
                                  .getEndedSubscriptionsPlayers(playersCount,DateTime.now()): PlayersDatabaseManager()
                                  .getEndedSubscriptionsPlayers(customDateTime.begDate,customDateTime.endDate),
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
                                                snapshot.data![index].playerId);
                                          });
                                    }

                                    Future.delayed(const Duration(seconds: 0),
                                            () {
                                          playersListLength.state =
                                              snapshot.data!.length;
                                        });
                                    return Center(
                                      child: Text(
                                          "No ended subscriptions players"),
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
                                                snapshot.data![index].playerId);
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
                )
              )

            ],
          ),
        ),
      ),
    );
  }
}