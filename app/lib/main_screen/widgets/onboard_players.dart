import 'package:flutter/material.dart';
import 'package:gym_management/main_screen/widgets/player_name_widget.dart';

class OnBoardPlayers extends StatefulWidget {
  final String title;
  const OnBoardPlayers({super.key,required this.title});

  @override
  State<OnBoardPlayers> createState() => _OnBoardPlayersState();
}

class _OnBoardPlayersState extends State<OnBoardPlayers> {
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: MediaQuery.sizeOf(context).height * 0.9,
      child:  Card(child:
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title),
                  Text("22"),
                ],
              ),
              SizedBox(height: 40,),
              Expanded(child:Scrollbar(
                controller: _firstController,
                  thumbVisibility: true,
                  child: ListView.builder(
                      controller: _firstController,
                    itemCount: 40,
                  shrinkWrap: false,
                  itemBuilder: (context,index)=>PlayerNameWidget())))
            ],
          ),
        ),),
    );
  }
}
