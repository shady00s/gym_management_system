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
    DurationModel("Past 30 days", 30),

];
List<GenderModel>  genders  = [
  GenderModel("All", ""),
  GenderModel("Male", "Male"),
  GenderModel("Female", "Female"),
];


var endedPlayersDurationProvider = StateProvider<int>((ref) =>0);
var endedPlayersDurationProviderList = FutureProvider<List<Player>>((ref) => PlayersDatabaseManager().getEndedSubscriptionsPlayers(ref.watch(endedPlayersDurationProvider)));

class PlayerStatusWidget extends StatelessWidget {
  const PlayerStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Status",
            style: TextStyle(fontSize: 31, fontWeight: FontWeight.w800),
          ),
        ),
        // number card
         Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              SizedBox (
                width: 250,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("21",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w500)),
                        Text("New players  ")
                      ],
                    ),
                  ),
                ),
              ),
              Consumer(
                builder: (key,ref,child){
                  var list = ref.watch(endedPlayersDurationProviderList);

                  return  list.when(data: (val)=> Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [  Text(val.length.toString(),style: TextStyle(fontSize: 36,fontWeight: FontWeight.w500)),
                            Text("players with ended subscription")],
                        ),
                      ),
                    ),
                  ), error: (err,state)=>Text("Error"), loading: ()=> Center(child: ProgressRing(),))
                  ;
                },

              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text("21",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w500)),
                        Text("Total active players")],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // filter by widget
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical:3),
            child: Row(
              children: [
                Expanded(
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

                        ComboBoxWidget(items: durationList, filterTitle: 'Duration', onChanged: (int val){},),
                        SizedBox(width: 8,),

                        ComboBoxWidget(items: genders, filterTitle: "Gender", onChanged: (int val){},)
                      ],
                    ),
                  ),
                ),

                Expanded(
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

                          final setDate = ref.read(endedPlayersDurationProvider.notifier) ;

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
                Expanded(
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

                        ComboBoxWidget(items: durationList, filterTitle: 'Duration',onChanged: (int val){},),

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
                  child: FutureBuilder<List<Player>>(
                      future:
                          PlayersDatabaseManager().getNewPlayersSubscriptions(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) =>
                                    PlayerNameWidget(
                                        snapshot.data![index].playerName,
                                        snapshot.data![index].playerId),
                              );
                            }
                            return Center(
                              child: Text("No new players"),
                            );
                          default:
                            return Center(
                              child: ProgressRing(),
                            );
                        }
                      }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Consumer(

                    builder:(key,ref,child){
                      int days = ref.watch(endedPlayersDurationProvider);
                    return Consumer(builder: (key,ref,child){

                      var playerList = ref.watch(endedPlayersDurationProviderList);

                      return playerList.when(data: (data)=> ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index) =>
                            PlayerNameWidget(
                                data![index].playerName,
                                data![index].playerId),
                      ), error: (err,state)=>Text("Error occured"), loading: ()=>Center(child: ProgressRing(),));
                    });


                      FutureBuilder<List<Player>>(
                        future: PlayersDatabaseManager()
                            .getEndedSubscriptionsPlayers(days),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) =>
                                      PlayerNameWidget(
                                          snapshot.data![index].playerName,
                                          snapshot.data![index].playerId),
                                );
                              }
                              return Center(
                                child: Text("No new players"),
                              );
                            default:
                              return Center(
                                child: ProgressRing(),
                              );
                          }
                        });}
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        PlayerNameWidget("test", 1),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
