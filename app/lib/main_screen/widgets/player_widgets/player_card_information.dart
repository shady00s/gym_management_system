import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:intl/intl.dart';
import '../../../database_management/tables/generate_table.dart';

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
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: const  Text("Teams:")),
                          Expanded(
                              flex: 3,
                              child: Wrap(children: snapshot.data!.map((e){
                                return Card(child: Text(e.teamName!));
                      }).toList(),))
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Text("Subscriptions history:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                      const SizedBox(height: 14,),

                      Expanded(child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index)=>Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const   Text("Beginning date:"),
                                        Text((DateFormat.yMMMEd().format(snapshot.data![index].beginningDate)))
                                      ],),
                                  ),

                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const    Text("end date:"),
                                        Text(DateFormat.yMMMEd().format(snapshot.data![index].endDate))
                                      ],),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Duration :"),
                                        Text(snapshot.data![index].duration == 1? "1 Month":snapshot.data![index].duration == 3?"3 Months":snapshot.data![index].duration == 6? "6 Months":snapshot.data![index].duration == 11?"1 session":snapshot.data![index].duration == 12?"1 Year":"Unknown")
                                      ],),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Value :"),
                                        Text(snapshot.data![index].billValue == -1? "Unknown" : snapshot.data![index].billValue.toString())
                                      ],),
                                  ),
                                ],),
                            ),
                          )))

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