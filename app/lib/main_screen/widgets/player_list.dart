import 'package:flutter/material.dart' as material;
import 'package:gym_management/main_screen/widgets/playerListItemWidget.dart';
import "package:dio/dio.dart";
import "package:fluent_ui/fluent_ui.dart";
import 'package:gym_management/main_screen/widgets/player_name_widget.dart';
class PlayersListWidget extends StatelessWidget {
  PlayersListWidget({super.key});

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPlayersFromRender(),
        builder: (context, snapshot) {

          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: ProgressRing(),);

            case ConnectionState.done:
              if(snapshot.hasData){
                return  Scrollbar(
                    controller: controller,
                    child: ListView.builder(
                        controller: controller,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index)=> PlayerNameWidget("${snapshot.data[index]["player_name"]}", index )));
              }else{
                return Center(child: Text("No data found"),);
              }


            default:
              return Center(child: ProgressBar(),);
          }

        }
      );
  }
}
Future getPlayersFromRender() async{
  final dio = Dio();
  var responseData = await dio.get("http://127.0.1.1:3000/get_players_data_from_db");
  return responseData.data["data"];
}
