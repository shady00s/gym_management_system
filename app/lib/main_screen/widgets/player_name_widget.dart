import 'package:flutter/material.dart';

class PlayerNameWidget extends StatelessWidget {
  const PlayerNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
          borderRadius: BorderRadius.circular(5),
        onTap:(){},child:  Padding(
          padding:const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("shady safwat kamal el deen"),
              PopupMenuButton(itemBuilder: (context)=>[
                PopupMenuItem(child: Row(children: [
                  Icon(Icons.refresh),
                  Text("Re-new subscription"),

                ],)),
                PopupMenuItem(child: Row(children: [
                  Icon(Icons.insert_invitation_rounded),
                  Text("Add Invitation"),

                ],)),
                PopupMenuItem(child: Row(children: [
                  Icon(Icons.stop),
                  Text("Freeze player"),

                ],)),
              ])
            ],
          ),
        ),),
    );
  }
}
