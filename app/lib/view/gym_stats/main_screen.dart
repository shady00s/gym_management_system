import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/main_screen/gym_stats/year_performance_widget.dart';

class GymStatMainScreenWidget extends StatelessWidget {
  const GymStatMainScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      backgroundColor: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Gym status",style: TextStyle(color: Colors.yellow,fontSize: 21, fontWeight: FontWeight.bold),),
          ),


          const YearPerformanceWidget()


        ],
      ),
    );
  }
}
