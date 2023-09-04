import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/need_resbscribe_player_name_widget.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_name_widget.dart';

import '../../../database_management/models/need_to_resubscribe_model.dart';

class OnBoardPlayers extends StatelessWidget {
  final String title;
  final Future data;
  OnBoardPlayers({super.key, required this.title, required this.data});

  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: MediaQuery.sizeOf(context).height * 0.9,
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<GetEndedSubscriptionByTeamResult>>(
                  future: data as Future<List<GetEndedSubscriptionByTeamResult>>,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: ProgressRing(),
                        );
                      case ConnectionState.done:
                        if (snapshot.data!.isNotEmpty && snapshot.hasData) {
                          return Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(title),
                                Text(snapshot.data!.length.toString()),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Expanded(
                                child: Scrollbar(
                                    controller: _firstController,
                                    thumbVisibility: true,
                                    child: ListView.builder(
                                        controller: _firstController,
                                        itemCount: snapshot.data!.length,
                                        shrinkWrap: false,
                                        itemBuilder: (context, index) =>
                   NeedToResubscribePlayerNameWidget(
                       playerName: snapshot.data![index].playerName,
                     playerId:snapshot.data![index].playerId,
                     endDate:snapshot.data![index].endDate!, playerIndexId: snapshot.data![index].playerIndexId ,))))
                          ]);
                        } else {
                          return Center(
                            child: Text("No players found"),
                          );
                        }

                      default:
                        return Center(
                          child: ProgressBar(),
                        );
                    }
                    // return Scrollbar(
                    //    controller: _firstController,
                    //      thumbVisibility: true,
                    //      child: ListView.builder(
                    //          controller: _firstController,
                    //        itemCount: 40,
                    //      shrinkWrap: false,
                    //      itemBuilder: (context,index)=>PlayerNameWidget("",0)));
                  })),
        ));
  }
}
