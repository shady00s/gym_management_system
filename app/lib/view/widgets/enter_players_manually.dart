import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/gym_player_logs/gym_log_manager.dart';

import '../home_widget.dart';

class EnterPlayersManually extends StatefulWidget {
  final int teamId;

  const EnterPlayersManually({super.key,required this.teamId});

  @override
  State<EnterPlayersManually> createState() => _EnterPlayersManuallyState();
}

class _EnterPlayersManuallyState extends State<EnterPlayersManually> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Consumer(


      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Card(
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Add players manually",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: 17),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormBox(
                    controller: _nameController,
                    validator: (text){
                      if(text == null){
                        return "Please add player name or id";
                      } return null;
                    },
                    placeholder: "Enter player ID or name",),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Button(child: const Text("Enter"), onPressed: ()async {
                      if(_globalKey.currentState!.validate()){

                        GymLogsManager().enterPlayer(_nameController.text.toString(), widget.teamId,context,false).then((value) =>  ref.invalidate(getPlayerLogsProvider));
                      }
                    }),
                  ),
                )
              ],),
          ),
        );
      },

    );
  }
}
