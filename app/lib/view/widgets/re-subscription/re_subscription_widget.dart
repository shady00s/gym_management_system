// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/gym_player_logs/gym_log_manager.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/view/widgets/player_widgets/add_new_player.dart';
import 'package:gym_management/view/widgets/re-subscription/form_widget.dart';
import 'package:intl/intl.dart';
import '../../../database_management/tables/generate_table.dart';
import '../player_widgets/player_status/player_status_widget.dart';
import '../take_new_image_widget.dart';

class RemainingData{
  late int playerPhoneNumber;
  late String? playerGender;
  late String playerImagePath;
  RemainingData({required this.playerPhoneNumber, required this.playerGender,required this.playerImagePath});
}
var remainingPlayerDataProvider = StateProvider<RemainingData>((ref)=> RemainingData(playerPhoneNumber: 20, playerGender: null,playerImagePath: ref.watch(playerImageProvider)??'no image'));
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
        height: MediaQuery.sizeOf(context).height * 0.99,
        child: Card(
          backgroundColor: Colors.black,
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text("Player Re-subscription",style: TextStyle(fontSize: 31,color: Colors.yellow),),
                      Consumer(

                        builder: (context, ref,child) {
                          var image = ref.watch(billImageProvider);

                          return IconButton(onPressed: () async{
                            if(image != null) {
                              await File(image).delete(recursive: true).then((value) =>  Navigator.of(context).pop());
                            var  imageState =  ref.read(billImageProvider.notifier);

                              imageState.state = null;

                            }else {
                              Navigator.of(context).pop();
                            }

                          },
                            icon:const Icon(FluentIcons.cancel),
                          );
                        }
                      )
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.85,
                    child: FutureBuilder<List<GetPlayerSubscriptionResult>>(future: PlayersDatabaseManager().getPlayerSubscriptionInfo(playerId),
                        builder: (BuildContext context, AsyncSnapshot<List<GetPlayerSubscriptionResult>> snapshot) {

                        switch(snapshot.connectionState){
                          case ConnectionState.active:
                            const Center(child: ProgressRing(),);
                          case ConnectionState.none:
                            return const Center(child: Text("Error occurred"),);
                          case ConnectionState.waiting:
                            return const Center(child: ProgressRing(),);
                          case ConnectionState.done:
                            if(snapshot.hasData && snapshot.data!.isNotEmpty){

                                int date = DateTime.now().difference(snapshot.data![0].endDate).inDays;

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      // player information
                                      SizedBox(
                                        width:MediaQuery.sizeOf(context).width * 0.25 ,
                                        height:MediaQuery.sizeOf(context).height * 0.6,
                                        child: Card(
                                          backgroundColor:const Color.fromRGBO(
                                              3, 3, 3, 1.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                 snapshot.data![0].imagePath == 'no image'? Column(
                                                   children: [
                                                     const Padding(
                                                    padding:  EdgeInsets.all(8.0),
                                                    child: Align(alignment: AlignmentDirectional.topStart,child:Text('Player image',style:TextStyle(fontWeight:FontWeight.bold)),
                                                    )),
                                                     TakeNewImageWidget(
                                                       path: 'players_images',
                                                       state: playerImageProvider,
                                                     ),
                                                     Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Align(alignment: AlignmentDirectional.topStart,child:Text('please add player image',style:TextStyle(color:Colors.red.light,)),
                                                           ),
                                                     )

                                                   ],
                                                 ) : CircleAvatar(foregroundImage: FileImage(File(snapshot.data![0].imagePath)),radius: 33,),
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
                                                    const Text("Gender:"),
                                                    Text(snapshot.data![0].playerGender),
                                                  ],
                                                ),
                                                if(snapshot.data![0].playerGender=='un recorded')
                                                  Consumer(

                                                    builder: (context, ref,child) {
                                                      var remainingData = ref.watch(remainingPlayerDataProvider);
                                                      var setRemainingData = ref.read(remainingPlayerDataProvider.notifier);

                                                      return Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:CrossAxisAlignment.start,
                                                          children: [
                                                            Text('please add player gender',style:TextStyle(color:Colors.red.light,)),
                                                           const  SizedBox(height:9),
                                                              ComboBox<String>(
                                                                value: remainingData.playerGender,
                                                                  placeholder: Text("Select gender"),
                                                                  onChanged: (val){
                                                                    setRemainingData.state = RemainingData(playerPhoneNumber: remainingData.playerPhoneNumber, playerGender: val??'', playerImagePath: remainingData.playerImagePath);
                                                                  },
                                                                  items: genders.map((e)=>ComboBoxItem(value:e.value,child: Text(e.value))).toList())
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  ),
                                                const SizedBox(height: 14,),

                                                snapshot.data![0].playerPhoneNumber != -1?  Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text("Phone number:"),

                                                    Text(snapshot.data![0].playerPhoneNumber.toString())
                                                  ],
                                                )
                                                :Consumer(

                                                  builder: (context, ref,child) {
                                                    var remainingData = ref.watch(remainingPlayerDataProvider);
                                                    var setRemainingData = ref.read(remainingPlayerDataProvider.notifier);
                                                    return Column(
                                                      crossAxisAlignment:CrossAxisAlignment.start,
                                                      children: [
                                                        const Row(
                                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                        children: [
                                                           Text("Phone number:"),
                                                          Text('Unrecorded')
                                                        ],
                                                      ),
                                                        const  SizedBox(height:12),
                                                      Text('please add player phone number',style:TextStyle(color:Colors.red.light,)),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: SizedBox(width:212, child:NumberFormBox(
                                                            value: remainingData.playerPhoneNumber,
                                                            onChanged:(val){
                                                              setRemainingData.state = RemainingData(playerPhoneNumber: val!, playerGender: remainingData.playerGender, playerImagePath: remainingData.playerImagePath);
                                                            },
                                                            mode:SpinButtonPlacementMode.none)),
                                                      )

                                                    ],);
                                                  }
                                                ),
                                                const SizedBox(height: 14,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const  Text("First join date:"),
                                                    Align(
                                                        alignment:AlignmentDirectional.centerEnd,
                                                        child: Text((DateFormat.yMMMMEEEEd().format(snapshot.data![0].playerFirstJoinDate) ).toString())),
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
                                                    const Expanded(
                                                        flex: 1,
                                                        child: Text("Teams:")),
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
                                      ),
                                      // last subscription card and last seen
                                      Expanded(
                                        child: Card(backgroundColor:const Color.fromRGBO(
                                            4, 4, 4, 1.0),child:  Column(children: [
                                          const  Text("Last subscription",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                                          const  SizedBox(height: 20,),
                                          SingleChildScrollView(
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
                                                          Text(snapshot.data![0].duration == 1? "1 Month":snapshot.data![0].duration == 3?"3 Months":snapshot.data![0].duration == 6? "6 Months":snapshot.data![0].duration == 11?"1 session":snapshot.data![0].duration == 12?"1 Year":"Unknown",
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
                                                              const   Text("Beginning date:"),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 9,),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal:12.0),
                                                            child: Text((DateFormat.yMMMEd().format(snapshot.data![0].beginningDate))),
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
                                                            child: Text(DateFormat.yMMMEd().format(snapshot.data![0].endDate)),
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
                                                          Text(snapshot.data![0].billValue == -1? "Unknown" : snapshot.data![0].billValue.toString())
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
                                                          Text(snapshot.data![0].billValue == -1? "Unknown" : snapshot.data![0].billValue.toString())
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
                                                          Text(snapshot.data![0].billValue == -1? "Unknown" : snapshot.data![0].billValue.toString())
                                                        ],),
                                                    ),
                                                  ],


                                                ),
                                              )
                                          ),
                                          const   SizedBox(height: 20,),
                                          const Text("Last player seen date",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                                          const SizedBox(height: 10,),
                                            Consumer(
                                              builder: (context, ref,child) {
                                                var setPlayerLastSeen = ref.read(playerLastSeenProvider.notifier);
                                                return FutureBuilder<DateTime?>(future:GymLogsManager().getPlayerLastSeen(snapshot.data![0].playerIndexId, snapshot.data![0].teamId) ,
                                                  builder: (BuildContext context, AsyncSnapshot<DateTime?> snapshot) {

                                                      switch(snapshot.connectionState){
                                                        case ConnectionState.none:
                                                          return const Text("Error occured");
                                                        case ConnectionState.waiting:
                                                        case ConnectionState.active:
                                                          return const Center(child: ProgressRing(),);
                                                        case ConnectionState.done:
                                                          if(snapshot.hasData && snapshot.data !=null) {
                                                            Future.delayed(Duration.zero,(){
                                                              setPlayerLastSeen.state = snapshot.data!;
                                                            });

                                                            return Card(child: Text(DateFormat.yMMMEd().format(snapshot.data!)));
                                                          }else{
                                                            return const Text("No records found");
                                                          }
                                                      }

                                                  }, );
                                              }
                                            )



                                        ],),),
                                      ),

                                      // subscription form
                                        ReSubscriptionFormWidget(playerIndexId: snapshot.data![0].playerIndexId,)


                                    ],
                                  ),
                                );
                              }
                            }return const Center(child: Text("No player information available"),);
                        }
                    ,),
                  )
              ],),
        ),
      ),
    ),);
  }
}

