import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/view/gym_stats/main_screen.dart';
import 'package:gym_management/view/widgets/employees_widget/employees_manager_widget.dart';
import 'package:gym_management/view/widgets/players_log_list.dart';
import 'package:gym_management/view/widgets/subscription_information/add_new_subscription_value_widget.dart';
import 'package:gym_management/view/home_widget.dart';
import 'package:gym_management/view/widgets/player_widgets/player_status/player_status_widget.dart';

import 'manage_excel/ui_widget.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

var navigationProvider = StateProvider((ref) => 0);
class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return
         Consumer(
           builder: (context, ref,child) {
            int currentIndex = ref.watch(navigationProvider);
            var setCurrentIndex = ref.read(navigationProvider.notifier);
             return NavigationView(
               appBar: const NavigationAppBar(
                 automaticallyImplyLeading: false
               ),
               pane:  NavigationPane(
                 selected: currentIndex,
                 onChanged: (val){
                   setCurrentIndex.state = val;
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
                   PaneItem(icon: const Icon(FluentIcons.home),title: const Text("Employees manager"), body: const EmployeesManagerWidget()),
                   PaneItemSeparator(),

                   PaneItem(icon: const Icon(FluentIcons.people_repeat),title: const Text("Players logs"), body:const PlayersLogsWidget()),


                 ]
               ),

             );
           }
         );
  }
}
