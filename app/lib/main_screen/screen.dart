import 'package:flutter/material.dart';
import 'package:gym_management/main_screen/widgets/cards_with_icons.dart';
import 'package:gym_management/main_screen/widgets/onboard_players.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex:2,child: OnBoardPlayers(title:"Active players for today:")),
        Expanded(
          flex: 3,
          child: Column(children: [
            Expanded(flex:3,child: Text("")),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Quick access"),
              ),),
            Expanded(
                child: GridView(

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            children: [
              CardsWithIcon(title: 'Re-new subscription', icon: Icons.refresh,),
              CardsWithIcon(title: 'Show price list', icon: Icons.list_alt_outlined),

            ],))

          ],),
        ),
        Expanded(
            flex:2,
            child: OnBoardPlayers(title:"Players need to subscribe:")),

      ],),
    );
  }
}
