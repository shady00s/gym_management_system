import 'package:flutter/material.dart';
import 'package:gym_management/main_screen/widgets/player_list.dart';
import 'package:gym_management/main_screen/widgets/search_bar_widget.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text("Search"),

       const SearchBarWidget(),
           Expanded(child: PlayersListWidget())
      ],
    );
  }
}
