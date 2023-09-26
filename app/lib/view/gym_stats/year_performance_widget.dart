import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/gym_status_manager.dart';
import 'package:gym_management/database_management/tables/teams/teams_database_manager.dart';
import 'package:gym_management/view/widgets/combo_box_widget.dart';

import '../../database_management/models/teams_data_model.dart';
import '../../database_management/tables/generate_table.dart';
import 'chart_widget.dart';

List<CustomBoxData> yearList = [
  CustomBoxData(title: DateTime.now().year.toString(), id: DateTime.now().year),
  CustomBoxData(
      title: DateTime.now().subtract(const Duration(days: 365)).year.toString(),
      id: DateTime.now().subtract(const Duration(days: 365)).year),
  CustomBoxData(
      title: DateTime.now().subtract(const Duration(days: 730)).year.toString(),
      id: DateTime.now().subtract(const Duration(days: 730)).year),
  CustomBoxData(
      title:
          DateTime.now().subtract(const Duration(days: 1095)).year.toString(),
      id: DateTime.now().subtract(const Duration(days: 1095)).year),
  CustomBoxData(
      title:
          DateTime.now().subtract(const Duration(days: 1460)).year.toString(),
      id: DateTime.now().subtract(const Duration(days: 1460)).year),
];
StateProvider<int> yearProvider = StateProvider((ref) => DateTime.now().year);
var teamDataProvider = StateProvider<TeamsDataModel>((ref) => TeamsDataModel(bestTeamName: '', bestTeamTotalPlayer: 0, worstTeamTotalPlayer: 0, worstTeamName: '', bestTeamRevenue: 0, worstTeamRevenue: 0));


class YearPerformanceWidget extends StatelessWidget {
  const YearPerformanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Year performance",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Consumer(builder: (context, ref, child) {
                StateController<int> year = ref.read(yearProvider.notifier);
                int getYear = ref.watch(yearProvider);
                var setTeamsData = ref.read(teamDataProvider.notifier);

                Future.delayed(Duration.zero,()async{
                    List<TeamsDataTableData> listOfTeams = await   TeamsDatabaseManager().getAllTeams();
                    List<TeamDate> data = [];
                    int higherIndex = 0;
                    int lowerIndex = 0;
                    int lower = 9999999999999999;
                    int higher = 0;

                        for (var element in listOfTeams) {
                          await GymStatusManager().getBestAndWorstTeamsInfo(getYear,element.teamId).then((value){
                            data.add(TeamDate(teamName:  value.readNullable<String>('team_name')?? '', playersNumber:  value.readNullable<int>('COUNT(Players.player_name)')?? 0, revenue:  value.readNullable('SUM(PlayersSubscriptions.billValue)') ?? 0));
                          });
                        }
                    for (int idx = 0; idx < data.length ; idx++) {
                        int current = data[idx].revenue;

                        if(current > higher){
                          higher = current;
                          higherIndex = idx;
                        }
                        if(current < lower && data[idx].playersNumber != 0){
                          lower = current;
                          lowerIndex = idx;
                        }
                    }
                     setTeamsData.state = TeamsDataModel(
                         bestTeamName: data[higherIndex].teamName,
                        bestTeamTotalPlayer: data[higherIndex].playersNumber,
                        worstTeamTotalPlayer: data[lowerIndex].playersNumber,
                        worstTeamName: data[lowerIndex].teamName,
                        bestTeamRevenue: data[higherIndex].revenue,
                        worstTeamRevenue: data[lowerIndex].revenue);

                  });
                return ComboBoxWidget(
                    items: yearList,
                    filterTitle: "",
                    onChanged: (val) {
                      year.state = val.id;
                      print(val.id);
                    },
                    allButton: false);
              }),
            ],
          ),
           Center(
            child: Card(
              child: Column(
                children: [
                 Consumer(

                    builder: (context, ref,child) {
                      var getTotalRev = ref.watch(totalRevenueProvider);
                      return Text(
                        getTotalRev.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                      );
                    }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Total revenue"),
                ],
              ),
            ),
          ),
          const Text(
            "Year profit summary",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 300,
                  width: 640,
                  child: Consumer(

                    builder: (context, ref,child) {
                      var teamsData = ref.watch(teamDataProvider);

                      var getMonthsData = ref.watch(bestAndWorstMonthProvider);
                      return Wrap(
                        children: [
                          // best profit month
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 90,
                              width: 300,
                              child: Card(
                                  child: ListTile(
                                      leading: Icon(
                                        FluentIcons.medal_solid,
                                        color: Colors.yellow,
                                      ),
                                      title:  Text(getMonthsData.bestMonthName,
                                          style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                                      subtitle:  Text(
                                        "Best month",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      trailing: SizedBox(
                                        width:100,
                                        child: Column(

                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Revenue:"),
                                            Align(alignment: AlignmentDirectional.centerEnd,child: Text(getMonthsData.bestMonthRevenue.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),)
                                          ],
                                        ),
                                      ))),
                            ),
                          ),
                          // worst profit month
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height: 90,
                                width: 300,
                                child: Card(
                                    child: ListTile(
                                        leading: Icon(
                                          FluentIcons.arrow_tall_down_left,
                                          color: Colors.orange,
                                        ),
                                        title:  Text(getMonthsData.worstMonthName,
                                            style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                                        subtitle: const Text(
                                          "least profit",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        trailing: SizedBox(
                                          width:100,
                                          child: Column(

                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text("Revenue:"),
                                              Align(alignment: AlignmentDirectional.centerEnd,child: Text(getMonthsData.worstMonthRevenue.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),)
                                            ],
                                          ),
                                        )
                                    ))),
                          ),
                          //best team
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height: 143,
                                width: 300,
                                child: Card(
                                    child: ListTile(
                                        leading: Icon(
                                          FluentIcons.warning,
                                          color: Colors.yellow,
                                        ),
                                        title:  Text(teamsData.bestTeamName,
                                            style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                                        subtitle: const Text("Best team"),
                                        trailing: SizedBox(
                                          width:100,
                                          child: Column(

                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [

                                              Text("Revenue: "),
                                              Align(alignment: AlignmentDirectional.centerEnd,child: Text(teamsData.bestTeamRevenue.toString(),
                                                  style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold))),

                                              const SizedBox(
                                                height: 8,
                                              ),

                                              Text("Players: "),
                                              Align(alignment: AlignmentDirectional.centerEnd,child: Text(teamsData.bestTeamTotalPlayer.toString(),
                      style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold))),



                                            ],
                                          ),
                                        )))),
                          ),
                          // least expensive month
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height: 143,
                                width: 300,
                                child: Card(
                                    child: ListTile(
                                        leading: Icon(
                                          FluentIcons.accept,
                                          color: Colors.green,
                                        ),
                                        title:  Text(teamsData.worstTeamName,style: TextStyle(fontWeight: FontWeight.bold),),
                                        subtitle: const Text("least Team"),
                                        trailing: SizedBox(
                                          width:100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [

                                              Text("Revenue: "),
                                              Align(alignment: AlignmentDirectional.centerEnd,child: Text(teamsData.worstTeamRevenue.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),)
                                              ,
                                              const SizedBox(
                                                height: 8,
                                              ),

                                              Text("Players: "),
                                              Align(alignment: AlignmentDirectional.centerEnd,child: Text(teamsData.worstTeamTotalPlayer.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),)
                                              ,


                                            ],
                                          ),
                                        )))),
                          ),
                        ],
                      );
                    }
                  )),
              const ChartWidget()
            ],
          )
        ],
      ),
    );
  }
}
