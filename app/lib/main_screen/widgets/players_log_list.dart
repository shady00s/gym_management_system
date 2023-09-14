import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeModel{
  int day;
  int month;
  int year;
  TimeModel({required this.day,required this.month,required this.year});
}

var playersLogProvider = StateProvider<TimeModel>((ref) => TimeModel(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year));
class PlayersLogsWidget extends StatelessWidget {
  const PlayersLogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(backgroundColor: Colors.black,child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text("Players logs",style: TextStyle(color: Colors.yellow,fontSize: 21,fontWeight: FontWeight.bold),),
         const SizedBox(height: 15,),
         const Text("Select Date"),
          Consumer(

            builder: (context, ref,child) {
              var getDateValue = ref.watch(playersLogProvider);
              var setDateValue = ref.read(playersLogProvider.notifier);

              return Row(children:[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(width:75,child: NumberFormBox(mode:SpinButtonPlacementMode.none,value: getDateValue.day,onChanged: (val){setDateValue.state = TimeModel(day: val!, month: getDateValue.month, year:  getDateValue.year,);},)),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(width:75,child: NumberFormBox(mode:SpinButtonPlacementMode.none ,value: getDateValue.month,onChanged: (val){setDateValue.state = TimeModel(day: getDateValue.day, month: val!, year:  getDateValue.year,);})),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(width:90,child: NumberFormBox(mode:SpinButtonPlacementMode.none,value: getDateValue.year,onChanged: (val3){setDateValue.state = TimeModel(day: getDateValue.day, month:  getDateValue.month, year:val3!);})),
                ),

              ]);
            }
          )
    ],),);
  }
}
