import 'package:flutter/material.dart';
import 'package:gym_management/main_screen/widgets/playerListItemWidget.dart';

class PlayersListWidget extends StatelessWidget {
  PlayersListWidget({super.key});

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  Scrollbar(
      controller: controller,
      child: ListView.builder(
        controller: controller,
        itemCount: 80,
        itemBuilder: (context,index)=>const PlayerListItemWidget()),);
  }
}
