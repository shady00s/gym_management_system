import 'dart:core';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_status/active_players.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_status/ended_subscription_players.dart';
import 'new_players.dart';

class DurationModel {
  final String title;
  final DurationTime value;

  DurationModel({required this.title,required this.value});
}
class DurationTime{
  final DateTime begDate;
  final DateTime endDate;

  DurationTime({required this.begDate,required this.endDate});
}

class GenderModel {
  final String title;
  final String value;

  GenderModel(this.title, this.value);
}

List<DurationModel> durationList = [
  DurationModel(title:"Today",value: DurationTime(begDate:DateTime.now().subtract(const Duration(days: 2)),endDate: DateTime.now() ) ),
  DurationModel(title:"Past 10 days",value: DurationTime(begDate:DateTime.now().subtract(const Duration(days: 10)),endDate: DateTime.now() )),
  DurationModel(title:"Past 20 days",value: DurationTime(begDate:DateTime.now().subtract(const Duration(days: 20)),endDate: DateTime.now() )),
  DurationModel(title:"Past 1 month",value: DurationTime(begDate:DateTime.now().subtract(Duration(  days: DateTime.now().difference(DateTime.now().subtract(const Duration(days: 30))).inDays )),endDate: DateTime.now() )),
  DurationModel(title:"Past 2 months",value: DurationTime(begDate:DateTime.now().subtract(Duration(  days: DateTime.now().difference(DateTime.now().subtract(const Duration(days: 60))).inDays )),endDate: DateTime.now() )),
  DurationModel(title:"Past 3 months",value: DurationTime(begDate:DateTime.now().subtract(Duration(  days: DateTime.now().difference(DateTime.now().subtract(const Duration(days: 90))).inDays )),endDate: DateTime.now() )),
];



List<GenderModel> genders = [
  GenderModel("Male", "Male"),
  GenderModel("Female", "Female"),
];

var newPlayersAddedDurationProviderLength = StateProvider<int>((ref) => 0);

var endedPlayersDurationProviderListLength = StateProvider<int>((ref) => 0);

var activePlayersDurationProviderListLength = StateProvider<int>((ref) => 0);

class PlayerStatusWidget extends StatelessWidget {
  const PlayerStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          height: 820,
          width: MediaQuery.sizeOf(context).width,
          child:  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    SizedBox(
                  width: 300,
                  height: 50,
                  child:  Padding(
                    padding:const EdgeInsets.all(8.0),
                    child: Text(
                      "Status",
                      style: TextStyle(fontSize: 31, fontWeight: FontWeight.w600,color: Colors.yellow),
                    ),
                  ),
                ),

                SizedBox(
                  height: 625,
                  width:MediaQuery.sizeOf(context).width* 0.95,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 600,
                          width:MediaQuery.sizeOf(context).width* 0.3,
                          child:const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:  NewPlayersWidget(),
                          )),
                      SizedBox(
                          height: 600,
                          width:MediaQuery.sizeOf(context).width* 0.3
                          ,child:const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: EndedPlayersSubscriptionWidget(),
                          )),
                      SizedBox(
                          height: 600,
                          width:MediaQuery.sizeOf(context).width* 0.3,
                          child:const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: ActivePlayersWidget(),
                          ))
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
