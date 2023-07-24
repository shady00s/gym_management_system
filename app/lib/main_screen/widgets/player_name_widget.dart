import 'package:flutter/material.dart'as material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/main_screen/widgets/player_card_information.dart';
class PlayerNameWidget extends StatelessWidget {
  final  String playerName;
  final int playerId;

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
            content: PlayerCardInformationWidget(playerId: playerId,)
          ));
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
              Text(" - $playerId "??"no id")
            ],
          ),
        ),),
    );
  }
}
