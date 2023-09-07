import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/gym_player_logs/gym_log_manager.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/re-subscription/form_widget.dart';
import 'package:intl/intl.dart';
import '../../../database_management/tables/generate_table.dart';

StateProvider<DateTime?> playerLastSeenProvider = StateProvider<DateTime?>((ref) => null);

Future showReSubscriptionWidget(context,playerId) async{
  await showGeneralDialog(context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_,__,___)=> ReSubscriptionWidget(playerId:playerId));
}

File? image;
class ReSubscriptionWidget extends StatelessWidget {
  final int playerId;
  const ReSubscriptionWidget({super.key,required this.playerId});

  @override
  Widget build(BuildContext context) {
    return  Card(backgroundColor: const Color.fromRGBO(12, 2, 3, 0.3),child: Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.85,
        height: MediaQuery.sizeOf(context).height * 0.95,
        child: Card(
          backgroundColor: Colors.black,
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text("Player Re-subscription",style: TextStyle(fontSize: 31,color: Colors.yellow),),
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                        icon:const Icon(FluentIcons.cancel),
                      )
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    child: FutureBuilder<List<GetPlayerSubscriptionResult>>(future: PlayersDatabaseManager().getPlayerSubscriptionInfo(playerId),
                        builder: (BuildContext context, AsyncSnapshot<List<GetPlayerSubscriptionResult>> snapshot) {

                        switch(snapshot.connectionState){
                          case ConnectionState.active:
                            Center(child: ProgressRing(),);
                          case ConnectionState.none:
                            return Center(child: Text("Error occured"),);
                          case ConnectionState.waiting:
                            return Center(child: ProgressRing(),);
                          case ConnectionState.done:
                            if(snapshot.hasData && snapshot.data!.isNotEmpty){

                                int date = DateTime.now().difference(snapshot.data![0].endDate).inDays;
                                print(snapshot.data![0].playerIndexId);

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      // player information
                                      Expanded(
                                        child: Card(
                                          backgroundColor:const Color.fromRGBO(
                                              3, 3, 3, 1.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const   CircleAvatar(
                                                radius: 33,
                                                backgroundColor: Color.fromRGBO(
                                                    176, 175, 175, 0.7019607843137254),
                                                child: Icon(FluentIcons.contact ,size: 41,),
                                              ),
                                              const  SizedBox(height: 22,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Name:"),
                                                  Text(snapshot.data![0].playerName),
                                                ],
                                              ),
                                              const  SizedBox(height: 14,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("ID:"),
                                                  Text((snapshot.data![0].playerId).toString()),
                                                ],
                                              ),
                                              SizedBox(height: 14,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Phone number:"),
                                                  Text((snapshot.data![0].playerPhoneNumber != -3?snapshot.data![0].playerPhoneNumber:"unrecorded").toString()),
                                                ],
                                              ),
                                              SizedBox(height: 14,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const  Text("First join date:"),
                                                  Text((DateFormat.yMMMMEEEEd().format(snapshot.data![0].playerFirstJoinDate) ).toString()),
                                                ],
                                              ),

                                              const SizedBox(height: 14,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const  Text("Status:"),
                                                  Text(date < 0 ?"Valid": date == 0? "Ended today" :"Ended $date day ago" ,style:

                                                  TextStyle(color:

                                                  date < 0 ?const Color.fromRGBO(
                                                      2, 176, 18, 0.8) : date <= 10?const Color.fromRGBO(
                                                      176, 173, 2, 0.8) :date <= 30?const Color.fromRGBO(
                                                      176, 80, 2, 0.8):const Color.fromRGBO(
                                                      176, 2, 2, 0.8) , fontWeight: FontWeight.bold, fontSize: 18),),
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: const  Text("Teams:")),
                                                  Expanded(
                                                      flex: 3,
                                                      child: FutureBuilder<List<TeamsDataTableData>>(
                                                          future: PlayersDatabaseManager().getPlayerTeams(playerId),
                                                          builder: (context, teamSnapshot) {

                                                            switch(teamSnapshot.connectionState){
                                                              case ConnectionState.waiting:
                                                                return const Center(child: ProgressRing(),);
                                                              case ConnectionState.done:
                                                                return Wrap(children: teamSnapshot.data!.map((e){
                                                                  return SizedBox(height: 45, child: Card(
                                                                      margin: EdgeInsets.zero, child: Text(e.teamName)));
                                                                }).toList(),);
                                                              default:
                                                                return const Center(child: ProgressRing(),);
                                                            }

                                                          }
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // last subscription card and last seen
                                      Expanded(
                                        child: Card(backgroundColor:const Color.fromRGBO(
                                            4, 4, 4, 1.0),child:  Column(children: [
                                          Text("Last subscription",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 20,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const   Text("Beginning date:"),
                                                Text((DateFormat.yMMMEd().format(snapshot.data![0].beginningDate!)))
                                              ],),
                                          ),

                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const    Text("end date:"),
                                                Text(DateFormat.yMMMEd().format(snapshot.data![0].endDate!))
                                              ],),
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Duration :"),
                                                Text(snapshot.data![0].duration == 1? "1 Month":snapshot.data![0].duration == 3?"3 Months":snapshot.data![0].duration == 6? "6 Months":snapshot.data![0].duration == 11?"1 session":snapshot.data![0].duration == 12?"1 Year":"Unknown")
                                              ],),
                                          ),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Value :"),
                                                Text(snapshot.data![0].billValue == -1? "Unknown" : snapshot.data![0].billValue.toString())
                                              ],),
                                          ),

                                          SizedBox(height: 20,),
                                          Text("Last player seen date",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 10,),
                                            Consumer(
                                              builder: (context, ref,child) {
                                                var setPlayerLastSeen = ref.read(playerLastSeenProvider.notifier);
                                                return FutureBuilder<DateTime?>(future:GymLogsManager().getPlayerLastSeen(snapshot.data![0].playerIndexId, snapshot.data![0].teamId) ,
                                                  builder: (BuildContext context, AsyncSnapshot<DateTime?> snapshot) {

                                                      switch(snapshot.connectionState){
                                                        case ConnectionState.none:
                                                          return Text("Error occured");
                                                        case ConnectionState.waiting:
                                                        case ConnectionState.active:
                                                          return Center(child: ProgressRing(),);
                                                        case ConnectionState.done:
                                                          if(snapshot.hasData && snapshot.data !=null) {
                                                            Future.delayed(Duration.zero,(){
                                                              setPlayerLastSeen.state = snapshot.data!;
                                                            });

                                                            return Card(child: Text(DateFormat.yMMMEd().format(snapshot.data!)));
                                                          }else{
                                                            return Text("No records found");
                                                          }
                                                      }

                                                  }, );
                                              }
                                            )



                                        ],),),
                                      ),

                                      // subscription form
                                       const ReSubscriptionFormWidget()


                                    ],
                                  ),
                                );
                              }
                            }return Center(child: Text("No player information available"),);
                        }
                    ,),
                  )
              ],),
        ),
      ),
    ),);
  }
}

