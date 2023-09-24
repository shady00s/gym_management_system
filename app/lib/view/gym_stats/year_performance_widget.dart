import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/view/widgets/combo_box_widget.dart';

import 'chart_widget.dart';

class MonthReviewModel{
  late int totalRevenue;
  late Map<String,dynamic> bestMonth;
  late Map<String,dynamic> leastMonth;
  MonthReviewModel({required this.totalRevenue,required this.bestMonth,required this.leastMonth});
}
var monthReviewProvider = StateProvider<MonthReviewModel>((ref) => MonthReviewModel(totalRevenue: 0, bestMonth: {"monthName":"","revenue":0}, leastMonth: {"monthName":"","revenue":0}));

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
                      var totalRev = ref.watch(monthReviewProvider);
                      return Text(
                        totalRev.totalRevenue.toString(),
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
                        var totalRev = ref.watch(monthReviewProvider);
                        return  Wrap(

                    children: [
                      // best profit month
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 90,
                          width: 300,
                          child: Card(
                              child:ListTile(
                                      leading: Icon(
                                        FluentIcons.medal_solid,
                                        color: Colors.yellow,
                                      ),
                                      title:  Text(totalRev.bestMonth['monthName'],
                                          style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                                      subtitle: const Text(
                                        "Best profit",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      trailing: SizedBox(
                                        width:90,
                                        child: Column(

                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Revenue: "),
                                            SizedBox(height: 9,),
                                            Align(alignment: AlignmentDirectional.centerEnd,child: Text( totalRev.bestMonth['revenue'].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green.light),),)


                                          ],
                                        ),
                                      ))

                              ),
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
                                    title:  Text( totalRev.leastMonth['monthName'],
                                        style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                                    subtitle: const Text(
                                      "lowest profit",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    trailing: SizedBox(
                                      width:90,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Revenue:"),
                                          SizedBox(height: 9,),

                                          Align(alignment: AlignmentDirectional.centerEnd,child:Text(totalRev.leastMonth['revenue'].toString(),style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.red.light),) ,)

                                        ],
                                      ),
                                    )))),
                      ),
                      //most expensive month
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 120,
                            width: 300,
                            child: Card(
                                child: ListTile(
                                    leading: Icon(
                                      FluentIcons.warning,
                                      color: Colors.yellow,
                                    ),
                                    title: const Text("May"),
                                    subtitle: const Text("expensive month"),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: const TextSpan(
                                              text: "Profit: ",
                                              children: [
                                                TextSpan(text: '23000')
                                              ]),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                              text: "Loss: ",
                                              children: [
                                                TextSpan(text: '13000')
                                              ]),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const Divider(),
                                        RichText(
                                          text: const TextSpan(
                                              text: "Revenue: ",
                                              children: [
                                                TextSpan(text: '13000')
                                              ]),
                                        ),
                                      ],
                                    )))),
                      ),
                      // least expensive month
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 120,
                            width: 300,
                            child: Card(
                                child: ListTile(
                                    leading: Icon(
                                      FluentIcons.accept,
                                      color: Colors.green,
                                    ),
                                    title: const Text("May"),
                                    subtitle: const Text("least expensive"),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: const TextSpan(
                                              text: "Profit: ",
                                              children: [
                                                TextSpan(text: '23000')
                                              ]),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                              text: "Loss: ",
                                              children: [
                                                TextSpan(text: '13000')
                                              ]),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const Divider(),
                                        RichText(
                                          text: const TextSpan(
                                              text: "Revenue: ",
                                              children: [
                                                TextSpan(text: '13000')
                                              ]),
                                        ),
                                      ],
                                    )))),
                      ),
                    ],
                  );})
                    ),
              const ChartWidget()
            ],
          )
        ],
      ),
    );
  }
}
