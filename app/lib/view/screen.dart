import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/main_screen/gym_stats/main_screen.dart';
import 'package:gym_management/main_screen/widgets/players_log_list.dart';
import 'package:gym_management/main_screen/widgets/subscription_information/add_new_subscription_value_widget.dart';
import 'package:gym_management/main_screen/home_widget.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_status/player_status_widget.dart';

import '../manage_excel/ui_widget.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return
         NavigationView(
           appBar: const NavigationAppBar(
             automaticallyImplyLeading: false
           ),
           pane: NavigationPane(
             selected: currentIndex,
             onChanged: (val){
               setState(() {
                 currentIndex = val;
               });
             },
             displayMode: PaneDisplayMode.minimal,
             items: [
               PaneItem(icon: const Icon(FluentIcons.home),title: const Text("Home"), body: const HomeWidget()),
              PaneItemSeparator(),
               PaneItem(infoBadge: InfoBadge(color: Colors.yellow,),icon: const Icon(FluentIcons.connect_contacts),title: const Text("All players Status"), body:const PlayerStatusWidget()),
               PaneItemSeparator(),
               PaneItem(infoBadge: InfoBadge(color: Colors.yellow,),icon: const Icon(FluentIcons.align_vertical_bottom),title: const Text("Gym players Status"), body:const GymStatMainScreenWidget()),
               PaneItemSeparator(),
               PaneItem(icon: const Icon(FluentIcons.pencil_reply),title: const Text("Add new subscription"), body:const AddNewSubscriptionValueWidget()),
               PaneItemSeparator(),
               PaneItem(icon: const Icon(FluentIcons.office_logo),title: const Text("Get excel data"), body:const ImportExcelScreen()),
               PaneItemSeparator(),

               PaneItem(icon: const Icon(FluentIcons.people_repeat),title: const Text("Players logs"), body:const PlayersLogsWidget()),


             ]
           ),

         );
  }
}
