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
              IconButton(onPressed: (){}, icon: Icon(Icons.settings))
            ],
          ),
        ),),
    );
  }
}
