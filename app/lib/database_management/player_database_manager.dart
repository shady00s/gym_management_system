import 'package:dio/dio.dart';
import 'package:gym_management/database_management/tables/players_table.dart';
class PlayersDatabaseManager{
  static final  PlayersDatabase _playersDatabase = PlayersDatabase();
  final Dio _dio = Dio();

  Future getDataFromBackup()async{
    await _dio.get("http://127.0.1.1:3000/get_players_data_from_db").then((playersValue) async{
      var playersData =  playersValue.data["data"];
      int length = await _playersDatabase.select($PlayersTable(_playersDatabase)).get().then((value) => value.length);
      if (length == 0){
        for(var data in playersData){
          await  _playersDatabase.into($PlayersTable(_playersDatabase)).insert( PlayersCompanion.insert(playerId: data["player_id"], playerName: data["player_name"], playerPhoneNumber: data["player_phone_number"], imagePath: data["image_path"], playerAge: data["player_age"], playerFirstJoinDate: data["player_first_join_date"] ?? DateTime(2010-01-01), playerGender: data["player_gender"], subscriptionId: data["subscription_id"]));

        }


        print("backup compelete");
      }
    }).catchError((err){
      print(err);
    });

    print("no backup ");
  }

  Future<List<Player>> getPlayersData()async{
    var data =  _playersDatabase.select($PlayersTable(_playersDatabase))..limit(300)..get();
    List<Player> responseData = await data.get();
    print(responseData.length);
    return responseData;
  }

  Future searchForPlayer(String searchInput)async{

    var res =   _playersDatabase.select($PlayersTable(_playersDatabase))..where((player){
      int?  value = int.tryParse(searchInput);
      if(value == null){
          return  player.playerName.equals(searchInput);
      } else if( searchInput.length < 11 ){
        return  player.playerId.equals(value);
      }else{
        return  player.playerPhoneNumber.equals(value);

      }
    }
    )..get();
    print( await res.get());
  }
}
