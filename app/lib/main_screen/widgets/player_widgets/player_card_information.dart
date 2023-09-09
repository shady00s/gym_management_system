import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:intl/intl.dart';
import '../../../database_management/tables/generate_table.dart';
import '../calender_widget.dart';

class PlayerCardInformationWidget extends StatelessWidget {
  final int playerId;
  const PlayerCardInformationWidget({super.key,required this.playerId});
  Future<List<GetPlayerSubscriptionResult>> getPlayerInfo()async{
    return  await PlayersDatabaseManager().getPlayerSubscriptionInfo(playerId);
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<GetPlayerSubscriptionResult>>(
        future: getPlayerInfo(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return const Center(child: ProgressRing(),);
            case ConnectionState.done:
              if(snapshot.hasData){
                int date = DateTime.now().difference(snapshot.data![0].endDate).inDays;
                print(snapshot.data![0].playerIndexId);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // player  info
                      Expanded(
                        flex: 2,
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  const Text("Name:"),
                                  Text(snapshot.data![0].playerName),
                                ],
                              ),
                              const  SizedBox(height: 14,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("ID:"),
                                  Text((snapshot.data![0].playerId).toString()),
                                ],
                              ),
                              const SizedBox(height: 14,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Phone number:"),
                                  Text((snapshot.data![0].playerPhoneNumber != -3?snapshot.data![0].playerPhoneNumber:"unrecorded").toString()),
                                ],
                              ),
                              const SizedBox(height: 14,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const  Text("First join date:"),
                                  Text((DateFormat.yMMMEd().format(snapshot.data![0].playerFirstJoinDate) ).toString()),
                                ],
                              ),

                              const SizedBox(height: 14,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const  Text("Status:"),
                                  Text(snapshot.data![0].duration == 11? "Needs to subscribe" : date < 0?"Valid": date == 0 ? "Ended today" :"Ended $date day ago" ,style:

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
                                  const Expanded(
                                      flex: 1,
                                      child: Text("Teams:")),
                                  Expanded(

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
                              const SizedBox(height: 30,),


                            ],
                          ),
                        ),
                      ),
                      // player subscription widget
                      Expanded(flex:2,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          const Text("Subscriptions history:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                          const SizedBox(height: 14,),

                          Expanded(flex:2,child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index)=>Padding(
                                padding: const EdgeInsets.all(8.0),

                                child: Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),

                                          child: Icon(FluentIcons.bill,color: Colors.yellow,),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Text(snapshot.data![index].duration == 1? "1 Month":snapshot.data![index].duration == 3?"3 Months":snapshot.data![index].duration == 6? "6 Months":snapshot.data![index].duration == 11?"1 session":snapshot.data![index].duration == 12?"1 Year":"Unknown",
                                              style: const TextStyle(fontSize: 18),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("no discount code"),
                                            ),
                                          ],
                                        )
                                      ],),

                                        const SizedBox(height: 10,),


                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(FluentIcons.timer,color: Colors.grey[90],),
                                                ),
                                                const   Text("Beginnig date:"),
                                              ],
                                            ),
                                            const SizedBox(height: 9,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:12.0),
                                              child: Text((DateFormat.yMMMEd().format(snapshot.data![index].beginningDate))),
                                            )
                                          ],),
                                      ),

                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(FluentIcons.timer,color: Colors.grey[90],),
                                                ),
                                                const    Text("end date:"),
                                              ],
                                            ),
                                            const SizedBox(height: 9,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:12.0),
                                              child: Text(DateFormat.yMMMEd().format(snapshot.data![index].endDate)),
                                            )
                                          ],),
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [ Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(FluentIcons.money,color: Colors.grey[90],),
                                              ),
                                                const Text("Value :"),
                                              ],
                                            ),
                                            const SizedBox(height: 9,),
                                            Text(snapshot.data![index].billValue == -1? "Unknown" : snapshot.data![index].billValue.toString())
                                          ],),
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(FluentIcons.snowflake,color: Colors.grey[90],),
                                                ),
                                                const Text("Freeze left :"),
                                              ],
                                            ),
                                            const SizedBox(height: 9,),
                                            Text(snapshot.data![index].billValue == -1? "Unknown" : snapshot.data![index].billValue.toString())
                                          ],),
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(FluentIcons.people,color: Colors.grey[90],),
                                              ),
                                              const Text("Invitations left :"),
                                            ],),

                                            const SizedBox(height: 9,),
                                            Text(snapshot.data![index].billValue == -1? "Unknown" : snapshot.data![index].billValue.toString())
                                          ],),
                                      ),
          ],


                                  )
                                ),
                                // child: Card(

                                // ),
                              )))
                        ],),
                      )),
                      // player log info
                        Expanded(flex:3,child: Padding(
                        padding:const  EdgeInsets.all(8.0),
                        child: Column(children: [
                          const Text("Player logs history:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                          const  SizedBox(height: 14,),
                          CalenderWidget(playerIndexId: snapshot.data![0].playerIndexId, teamId:snapshot.data![0].teamId ,)
                        ],),
                      ))

                    ],
                  ),
                );
              }
             return const Text("No data available");
            default:
              return  const Center(child: ProgressBar(),);


          }
        });
  }



}
