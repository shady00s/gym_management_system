import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_list.dart';
import 'package:gym_management/main_screen/widgets/search_widgets/search_bar_widget.dart';

class SearchWidget extends StatelessWidget {
  final int teamId;
  const SearchWidget({super.key ,required this.teamId});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text("Search"),

       const SearchBarWidget(),
           Expanded(child: PlayersListWidget(teamId: teamId,))
      ],
    );
  }
}
