import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';

class PlayerCardInformationWidget extends StatelessWidget {
  final int playerId;
  const PlayerCardInformationWidget({super.key,required this.playerId});
  Future getPlayerInfo()async{
    Dio dio = Dio();
    var res = await dio.get("http://127.0.1.1:3000/get_one_player_data_from_db",queryParameters: {
      "playerId":playerId
    });
    return res.data["data"];
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: getPlayerInfo(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: ProgressRing(),);
            case ConnectionState.done:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Name:"),
                        Text(snapshot.data["player_name"]),
                      ],
                    ),
                    SizedBox(height: 14,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ID:"),
                        Text((snapshot.data["player_id"]).toString()),
                      ],
                    ),
                    SizedBox(height: 14,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Phone number:"),
                        Text((snapshot.data["player_phone_number"] != -3?snapshot.data["player_phone_number"]:"unrecorded").toString()),
                      ],
                    ),
                    SizedBox(height: 30,),

                    Text("Subscriptions history:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                    SizedBox(height: 14,),

                    Expanded(child: ListView.builder(
                        itemCount: snapshot.data["subscriptions"].length,
                        itemBuilder: (context,index)=>Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Beginning date:"),
                                Text(snapshot.data["subscriptions"][index]["beginning_date"])
                              ],),

                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("end date:"),
                                Text(snapshot.data["subscriptions"][index]["end_date"])
                              ],),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Duration :"),
                                Text(snapshot.data["subscriptions"][index]["duration"] == 1? "1 Month":snapshot.data["subscriptions"][index]["duration"] == 3?"3 Months":snapshot.data["subscriptions"][index]["duration"] == 6? "6 Months":snapshot.data["subscriptions"][index]["duration"] == 11?"1 session":snapshot.data["subscriptions"][index]["duration"] == 12?"1 Year":"Unknown")
                              ],),
                          ],),
                        )))

                  ],
                ),
              );
            default:
              return  Center(child: ProgressBar(),);


          }
        });
  }
}
