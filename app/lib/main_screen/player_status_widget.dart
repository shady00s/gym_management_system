import 'dart:core';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/combo_box_widget.dart';
import 'package:gym_management/main_screen/widgets/player_name_widget.dart';

import '../database_management/tables/players_table.dart';


class DurationModel{
  final String title;
  final int value;

  DurationModel(this.title, this.value);


}
class GenderModel{
  final String title;
  final String value;

  GenderModel(this.title, this.value);

}
List<DurationModel> durationList = [
    DurationModel("Today", DateTime.now().day),
    DurationModel("Past 10 days", 10),
    DurationModel("Past 20 days", 20),
    DurationModel("Past 1 month", 30),
    DurationModel("Past 2 months", 60),
    DurationModel("Past 3 months", 90),
    DurationModel("Past 4 months", 120),
    DurationModel("Past 5 months", 150),
    DurationModel("Past 6 months", 180),
    DurationModel("Past 6 months", 210),
    DurationModel("Past 8 months", 240),
    DurationModel("Past 9 months", 270),
    DurationModel("Past 10 months", 300),
    DurationModel("Past 11 months", 330),
    DurationModel("Past 12 months", 360),
    DurationModel("Past 1 year", 365),
    DurationModel("Past 2 years", 730),

];
List<GenderModel>  genders  = [
  GenderModel("All", ""),
  GenderModel("Male", "Male"),
  GenderModel("Female", "Female"),
];

var newPlayersAddedDurationProvider = StateProvider<int>((ref) =>DateTime.now().day);
var newPlayersAddedDurationProviderLength = StateProvider<int>((ref) => 0);


var endedPlayersDurationProvider = StateProvider<int>((ref) =>DateTime.now().day);
var endedPlayersDurationProviderListLength = StateProvider<int>((ref) => 0);


var activePlayersDurationProvider = StateProvider<int>((ref) =>DateTime.now().day);
var activePlayersDurationProviderListLength = StateProvider<int>((ref) => 0);


class PlayerStatusWidget extends StatelessWidget {
  const PlayerStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
           Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Consumer(
                  builder: (key,ref,child){
                    var list = ref.watch(newPlayersAddedDurationProviderLength);

                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox (
                        width: 250,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(list.toString(),style:const TextStyle(fontSize: 36,fontWeight: FontWeight.w500)),
                                Text("New players  ")
                              ],
                            ),
                          ),
                        ),
                      ),

                    );
                  },

                ),

                Consumer(
                  builder: (key,ref,child){
                    var list = ref.watch(endedPlayersDurationProviderListLength);

                    return  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [  Text(list.toString(),style: TextStyle(fontSize: 36,fontWeight: FontWeight.w500)),
                              Text("players with ended subscription")],
                          ),
                        ),
                      ),

                    );
                  },

                ),

                Consumer(
                  builder: (key,ref,child){
                    var list = ref.watch(activePlayersDurationProviderListLength);

                    return  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [  Text(list.toString(),style: TextStyle(fontSize: 36,fontWeight: FontWeight.w500)),
                              Text("Total active players")],
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical:3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width:440,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text("Filter by"),
                          const Spacer(),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          const SizedBox(width: 8,),

                          Consumer(builder: (key, ref, child){

                            final setDate = ref.read(newPlayersAddedDurationProvider.notifier) ;

                            return  ComboBoxWidget(items: durationList, filterTitle: 'Duration', onChanged: (val){
                              setDate.state = val.value;
                            },);
                          }),
                          const  SizedBox(width: 8,),

                          ComboBoxWidget(items: genders, filterTitle: "Gender", onChanged: (int val){},)


                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width:440,
                    child: Padding(
                      padding:const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const   Text("Filter by"),
                          const Spacer(),
                          const   Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

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
                          const    SizedBox(width: 8,),

                          Consumer(builder: (key, ref, child){

                            final setDate = ref.read(endedPlayersDurationProvider.notifier) ;

                            return  ComboBoxWidget(items: durationList, filterTitle: 'Duration', onChanged: (val){
                              setDate.state = val.value;
                            },);
                          }),

                          const    SizedBox(width: 8,),

                          ComboBoxWidget(items: genders, filterTitle: "Gender",onChanged: (int val){},)
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width:440,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Filter by"),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

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
                          SizedBox(width: 8,),

                          Consumer(builder: (key, ref, child){

                            final setDate = ref.read(activePlayersDurationProvider.notifier) ;

                            return  ComboBoxWidget(items: durationList, filterTitle: 'Duration', onChanged: (val){
                              setDate.state = val.value;
                            },);
                          }),

                          SizedBox(width: 8,),

                          ComboBoxWidget(items: genders, filterTitle: "Gender",onChanged: (int val){},)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // players list
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Consumer(builder: (key,ref,child){

                            int playersCount = ref.watch(newPlayersAddedDurationProvider);
                            StateController<int> playersListLength = ref.read(newPlayersAddedDurationProviderLength.notifier);
                            return FutureBuilder<List<Player>>(
                                future:
                                PlayersDatabaseManager().getNewPlayersSubscriptions(playersCount),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.done:
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index)
                                            {
                                              Future.delayed(const Duration(seconds: 0),(){
                                                playersListLength.state = snapshot.data!.length;
                                              });


                                              return  PlayerNameWidget(
                                                  snapshot
                                                      .data![index].playerName,
                                                  snapshot.data![index].playerId);
                                            });
                                      }
                                      return Center(
                                        child: Text("No new players"),
                                      );
                                    default:
                                      return Center(
                                        child: ProgressRing(),
                                      );
                                  }
                                });



                        }
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:const EdgeInsets.all(8.0),
                    child:  Consumer(builder: (key,ref,child){

                        int playersCount = ref.watch(endedPlayersDurationProvider);
                        var playersListLength = ref.read(endedPlayersDurationProviderListLength.notifier);
                        return FutureBuilder<List<Player>>(
                            future:
                            PlayersDatabaseManager().getEndedSubscriptionsPlayers(playersCount),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.done:
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index)
                                      {
                                        Future.delayed(const Duration(seconds: 0),(){
                                          playersListLength.state = snapshot.data!.length;
                                        });


                                        return  PlayerNameWidget(
                                                  snapshot
                                                      .data![index].playerName,
                                                  snapshot.data![index].playerId);
                                            });
                                  }
                                  return Center(
                                    child: Text("No new players"),
                                  );
                                default:
                                  return Center(
                                    child: ProgressRing(),
                                  );
                              }
                            });



                       }
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:const EdgeInsets.all(8.0),
                    child:  Consumer(builder: (key,ref,child){

                      int playersCount = ref.watch(activePlayersDurationProvider);
                      var playersListLength = ref.read(activePlayersDurationProviderListLength.notifier);
                      return FutureBuilder<List<Player>>(
                          future:
                          PlayersDatabaseManager().getActivePlayersSubscriptions(playersCount),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index)
                                      {
                                        Future.delayed(const Duration(seconds: 0),(){
                                          playersListLength.state = snapshot.data!.length;
                                        });


                                        return  PlayerNameWidget(
                                            snapshot
                                                .data![index].playerName,
                                            snapshot.data![index].playerId);
                                      });
                                }
                                return Center(
                                  child: Text("No new players"),
                                );
                              default:
                                return Center(
                                  child: ProgressRing(),
                                );
                            }
                          });



                    }
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
