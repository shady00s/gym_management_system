import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';

class EnterPlayersManually extends StatelessWidget {
  final int teamId;
  const EnterPlayersManually({super.key,required this.teamId});

  @override
  Widget build(BuildContext context) {
    return  Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Add players manually",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: 17),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormBox(placeholder: "Enter player ID or name",),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(child: Text("Enter"), onPressed: (){
                PlayersDatabaseManager().enterPlayerToGym(teamId);
              }),
            ),
          )
        ],),
    );
  }
}
