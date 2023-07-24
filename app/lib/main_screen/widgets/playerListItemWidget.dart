import 'package:flutter/material.dart';
import 'package:gym_management/main_screen/widgets/player_name_widget.dart';

class PlayerListItemWidget extends StatelessWidget {
  const PlayerListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  PlayerNameWidget("",0);
  }
}
