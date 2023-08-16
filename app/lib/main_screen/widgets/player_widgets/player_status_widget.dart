import 'dart:core';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/combo_box_widget.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_name_widget.dart';

import '../../../database_management/tables/generate_table.dart';

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
  DurationModel("Past 10 days", DateTime.now().subtract(const Duration(days: 10))),
  DurationModel("Past 20 days", DateTime.now().subtract(const Duration(days: 20))),
  DurationModel("Past 1 month", DateTime.now().subtract(const Duration(days: 30))),
  DurationModel("Past 2 months", DateTime.now().subtract(const Duration(days: 60))),
  DurationModel("Past 3 months", DateTime.now().subtract(const Duration(days: 90))),
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
    StateProvider<DurationModel>((ref) => DurationModel("Not selected",DateTime.now()));

var endedPlayersDurationProviderListLength = StateProvider<int>((ref) => 0);

var activePlayersDurationProviderListLength = StateProvider<int>((ref) => 0);


var customEndSubscriptionDateProvider = StateProvider<CustomDateModel?>((ref) => null);

class PlayerStatusWidget extends StatelessWidget {
  const PlayerStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          height: 800,
          width: MediaQuery.sizeOf(context).width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const  SizedBox(
                  width: 300,
                  height: 50,
                  child:  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Status",
                      style: TextStyle(fontSize: 31, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                // number card
                SizedBox(
                  height: 150,
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
                  height:229,
                  width: MediaQuery.of(context).size.width * 0.98,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Expander(

                            header: Text("Filter by"), content: SizedBox(
                            height: 140,
                              child: SingleChildScrollView(
                                child: Column(
                                  children:[
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [
                                      Consumer(builder: (key, ref, child) {
                                        final setDate = ref.read(
                                            newPlayersAddedDurationProvider.notifier);

                                        return ComboBoxWidget(
                                          items: durationList,
                                          filterTitle: 'Coach',
                                          onChanged: (val) {
                                            setDate.state = val.value;
                                          },
                                        );
                                      }),
                                      Text("Not selected")
                                    ],),
                                    const Divider(),
                                    Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,

                                  children: [
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
                                    Text("Not selected")
                                  ],
                                ),
                                   const Divider(),
                                    Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,

                                  children: [
                                  Consumer(builder: (key, ref, child) {
                                    final setDate = ref.read(
                                        newPlayersAddedDurationProvider.notifier);

                                    return ComboBoxWidget(
                                      items: durationList,
                                      filterTitle: 'Sort by',
                                      onChanged: (val) {
                                        setDate.state = val.value;
                                      },
                                    );
                                  }),
                                    Text("Not selected")
                                ],),
                                   const Divider(),
                                    Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,

                                  children: [
                                    Consumer(builder: (key, ref, child) {
                                      final setDate = ref.read(
                                          newPlayersAddedDurationProvider.notifier);

                                      return ComboBoxWidget(
                                        items: durationList,
                                        filterTitle: 'Gender',
                                        onChanged: (val) {
                                          setDate.state = val.value;
                                        },
                                      );
                                    }),
                                    Text("Not selected")
                                  ],
                                ),
                                    const Divider(),
                                    Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,

                                  children: [
                                    Consumer(builder: (key, ref, child) {
                                      final setDate = ref.read(
                                          newPlayersAddedDurationProvider.notifier);

                                      return ComboBoxWidget(
                                        items: durationList,
                                        filterTitle: 'Subscription value',
                                        onChanged: (val) {
                                          setDate.state = val.value;
                                        },
                                      );
                                    }),
                                    Text("Not selected")
                                  ],
                                ),
                          ]),
                              ),
                            ),),
                        ),

                        SizedBox(width: 22),
                        Expanded(
                          child: Expander(header: Text("Filter by"),content:SizedBox(
                            height: 140,
                            child: SingleChildScrollView(
                                child:

                                Consumer(builder: (key, ref, child) {
                                  final setDate = ref.read(
                                      endedPlayersDurationProvider.notifier);
                                  DurationModel getChangedDate = ref.watch(endedPlayersDurationProvider);
                                  return Column(children: [
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ComboBoxWidget(
                                    items: durationList,
                                    filterTitle: 'Duration',
                                    onChanged: (val) {
                                      setDate.state = DurationModel(val.title, val.value);
                                    },
                                      ),
                                      Text(getChangedDate.title)

                                    ]),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
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
                                        Text("Not Selected")
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
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
                                        Text("Not Selected")
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
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
                                        Text("Not Selected")
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
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
                                        Text("Not Selected")
                                      ],
                                    ),
                                  ],)
                                  ;
                                }),



                              ),
                          ) ,),
                        ),
                        SizedBox(width: 22),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child:  Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.end,
                              children: [
                               Expander(header: Text("Filter by"), content: Column(children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                   ComboBoxWidget(
                                     items: genders,
                                     filterTitle: "Gender",
                                     onChanged: (int val) {},
                                   ),
                                    Text("Not selected")
                                 ],)
                               ],))


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
                  height: 300,
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
                                                  snapshot.data![index].playerId,
                                                  snapshot.data![index].playerIndexId

                                              );
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
                            var playersCount =
                            ref.watch(endedPlayersDurationProvider);

                            var customDateTime = ref.watch(customEndSubscriptionDateProvider);
                            var playersListLength = ref.read(
                                endedPlayersDurationProviderListLength.notifier);
                            return FutureBuilder<List<Player>>(
                                future:customDateTime == null? PlayersDatabaseManager()
                                    .getEndedSubscriptionsPlayers(playersCount.value,DateTime.now()): PlayersDatabaseManager()
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
                  )
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
