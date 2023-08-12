import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/cards_with_icons.dart';
import 'package:gym_management/main_screen/widgets/onboard_players.dart';
import 'package:gym_management/main_screen/widgets/search_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child:Center(child: Text("No Players added")) ),//OnBoardPlayers(title: "Active players for today:")),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Expanded(flex: 4, child: SearchWidget()),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Quick access"),
                ),
              ),
              Expanded(
                  flex: 1,
                  child:SizedBox(width:630, child:     Wrap(

                    children: [
                      CardsWithIcon(
                        title: 'Re-new subscription',
                        icon: FluentIcons.refresh,
                      ),
                      CardsWithIcon(
                          title: 'Show price list',
                          icon: FluentIcons.list),
                    ],
                  ),)

              )
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: OnBoardPlayers(title: "Players need to subscribe:", data: PlayersDatabaseManager().getNeedToResubscribePlayersSubscriptions(),)),
      ],
    );
  }
}
