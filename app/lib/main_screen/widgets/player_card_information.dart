import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/player_database_manager.dart';

import '../../database_management/models/backup_data_models.dart';

class PlayerCardInformationWidget extends StatelessWidget {
  final int playerId;
  const PlayerCardInformationWidget({super.key,required this.playerId});
  Future<PlayerProfileData> getPlayerInfo()async{
  debugPrint(playerId.toString());

    return  await PlayersDatabaseManager().getPlayerSubscriptionInfo(playerId);
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<PlayerProfileData>(
        future: getPlayerInfo(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: ProgressRing(),);
            case ConnectionState.done:
              if(snapshot.hasData){
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
                      SizedBox(height: 22,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name:"),
                          Text(snapshot.data!.profileData.playerName),
                        ],
                      ),
                      SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ID:"),
                          Text((snapshot.data!.profileData.playerId).toString()),
                        ],
                      ),
                      SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Phone number:"),
                          Text((snapshot.data!.profileData.playerPhoneNumber != -3?snapshot.data!.profileData.playerPhoneNumber:"unrecorded").toString()),
                        ],
                      ),
                      SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("First join date:"),
                          Text((snapshot.data!.profileData.playerFirstJoinDate.toString()).toString()),
                        ],
                      ),

                      SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Status:"),
                          Text("Valid",style: TextStyle(color:Color.fromRGBO(
                              2, 176, 18, 0.8), fontWeight: FontWeight.bold, fontSize: 18),),
                        ],
                      ),
                      SizedBox(height: 30,),

                      Text("Subscriptions history:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                      SizedBox(height: 14,),

                      Expanded(child: ListView.builder(
                          itemCount: snapshot.data!.subData.length,
                          itemBuilder: (context,index)=>Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Beginning date:"),
                                    Text(snapshot.data!.subData[index].beginningDate.toString())
                                  ],),

                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("end date:"),
                                    Text(snapshot.data!.subData[index].endDate.toString())
                                  ],),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Duration :"),
                                    Text(snapshot.data!.subData[index].duration == 1? "1 Month":snapshot.data!.subData[index].duration == 3?"3 Months":snapshot.data!.subData[index].duration == 6? "6 Months":snapshot.data!.subData[index].duration == 11?"1 session":snapshot.data!.subData[index].duration == 12?"1 Year":"Unknown")
                                  ],),
                              ],),
                          )))

                    ],
                  ),
                );
              }
             return Text("No data available");
            default:
              return  Center(child: ProgressBar(),);


          }
        });
  }
}
