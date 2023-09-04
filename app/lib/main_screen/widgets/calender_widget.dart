import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/gym_player_logs/gym_log_manager.dart';
import 'package:intl/intl.dart';

class CalenderWidget extends StatefulWidget {
  final int playerIndexId;
  final int teamId;
  const CalenderWidget({super.key,required this.playerIndexId, required this.teamId});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class CalenderModel{
  final String dayName;
  final String dayNumber;
  late  bool  isLogged;

  CalenderModel({required this.dayName,required this.dayNumber,required this.isLogged});
}
List<CalenderModel> calenderDays(){
  DateTime now = DateTime.now();

  int daysOfTheMonth = DateTime(now.year,now.month+1,0).day;
  int weekDay = DateTime(now.year,now.month+1,0).weekday;
  final dateFormat = DateFormat('EEEE'); // Format for day names
  final dayFormat = DateFormat('d');      // Format for day numbers



  final List<CalenderModel> dayList = [];

  for (int i = 1; i <= daysOfTheMonth; i++) {
    final day = DateTime(now.year, now.month, i);
    final dayName = dateFormat.format(day);
    final dayNumber = dayFormat.format(day);
    dayList.add(CalenderModel(dayName: dayName, dayNumber: dayNumber, isLogged: false));
  }

  // Adjust for the first day of the week
  for (int i = 0; i < weekDay - 1; i++) {
    dayList.insert(0,CalenderModel(dayName: '', dayNumber: '', isLogged: false));
  }

  return dayList;
}

Future<List<CalenderModel>> getPlayerLogsFromDb(playerIndexId, teamId)async{
  List<CalenderModel> days = calenderDays();
  Set<String> loggedDaysSet = {};

  List<DateTime> dateTime = await GymLogsManager().getPlayerLogs(playerIndexId, teamId);

  for (var date in dateTime) {
    loggedDaysSet.add(date.day.toString());
  }

  for (var element in days) {
    if (loggedDaysSet.contains(element.dayNumber)) {
      element.isLogged = true;
    }
  }
  return days;
}
class _CalenderWidgetState extends State<CalenderWidget> {

  @override
  Widget build(BuildContext context) {

    return  FutureBuilder<List<CalenderModel>>(
      future: getPlayerLogsFromDb(widget.playerIndexId, widget.teamId),
      builder: (context,AsyncSnapshot<List<CalenderModel>> snapshot) {

        switch (snapshot.connectionState){
          case ConnectionState.none:
            return Center(child: Text("Error occured"),);
          case ConnectionState.waiting:
          case ConnectionState.active:

            return Center(child: ProgressRing(),);
          case ConnectionState.done:
            return SizedBox(
              width: 300,

              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('fri'),
                      Text('sat'),
                      Text('sun'),
                      Text('mon'),
                      Text('tue'),
                      Text('wed'),
                      Text('thu'),

                    ],
                  ),
                  Wrap(children: snapshot.data!.map((e) =>Card(
                      backgroundColor:e.isLogged ==true? const Color.fromRGBO(
                          5, 152, 25, 1.0) : e.dayName==""?
                      const Color.fromRGBO(35, 35, 34, 0) :
                      const Color.fromRGBO(35, 35, 34, 1.0),
                      margin:const EdgeInsets.all(3), child: SizedBox(width: 20,height: 20,child: Center(child: Text(e.dayNumber)),)),).toList())
                ],
              ),
            );
        }

      }
    );
  }
}
