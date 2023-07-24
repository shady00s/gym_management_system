import 'package:dio/dio.dart';
import 'package:flutter/material.dart'as material;
import 'package:fluent_ui/fluent_ui.dart';
class PlayerNameWidget extends StatelessWidget {
  final  String playerName;
  final int playerId;

  Future getPlayerInfo()async{
    Dio dio = Dio();
    var res = await dio.get("http://127.0.1.1:3000/get_one_player_data_from_db",queryParameters: {
      "playerId":playerId + 1
    });
    return res.data["data"];
  }
   const PlayerNameWidget(this.playerName,this.playerId,{super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderRadius: BorderRadius.circular(5),
      child:  material.InkWell(
          borderRadius: BorderRadius.circular(5),
        onTap:()async{
          await showDialog(context: context, builder: (context)=> ContentDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Player Information"),
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                  icon: Icon(FluentIcons.cancel),
                )
              ],
            ),
            content: StatefulBuilder(builder: (context,setState)=>
                FutureBuilder(
                    future: getPlayerInfo(),
                    builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                      return Center(child: ProgressRing(),);
                    case ConnectionState.done:
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Name:"),
                              Text(snapshot.data[0]["player_name"]),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("ID:"),
                              Text(snapshot.data[0]["player_id"].toString()),
                            ],
                          ),
                          Text("Subscriptions history:"),
                          Expanded(child: ListView.builder(
                              itemCount: snapshot.data["subscriptions"].length,
                              itemBuilder: (context,index)=>Column(children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Beginning date:"),
                                Text(snapshot.data["subscriptions"]["beginning_date"])
                            ],),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("end date:"),
                                Text(snapshot.data["subscriptions"]["end_date"])
                            ],),

                          ],)))

                        ],
                      );
                       default:
                         return  Center(child: ProgressBar(),);


                  }
                }),)));
        },child:  Padding(
          padding:const EdgeInsets.all(8.0),
          child: Row(
            children: [
              material.PopupMenuButton(itemBuilder: (context)=>[
                material.PopupMenuItem(child: Row(children: [
                  Icon( material.Icons.refresh),
                  Text("Re-new subscription"),

                ],)),
                material.PopupMenuItem(child: Row(children: [
                  Icon( material.Icons.insert_invitation_rounded),
                  Text("Add Invitation"),

                ],)),
                material.PopupMenuItem(child: Row(children: [
                  Icon( material.Icons.stop),
                  Text("Freeze player"),

                ],)),
              ]),
              const Spacer(),
              Text(playerName??"No name"),
              Text(" - $playerId"??"no id")
            ],
          ),
        ),),
    );
  }
}
