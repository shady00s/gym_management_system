import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/view/gym_stats/year_performance_widget.dart';
import 'dart:math';
import '../../database_management/tables/gym_status_manager.dart';

List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  "Aug",
  "Sep",
  'Oct',
  'Nov',
  'Dec'
];

List<String> longMonths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  "August",
  "September",
  'October',
  'November',
  'December'
];

class BestAndWorstMonthModel {
  late String bestMonthName;
  late String worstMonthName;
  late int bestMonthRevenue;
  late int worstMonthRevenue;

  BestAndWorstMonthModel({required this.worstMonthRevenue,required this.bestMonthName,required this.bestMonthRevenue, required this.worstMonthName});
}

var bestAndWorstMonthProvider = StateProvider<BestAndWorstMonthModel>((ref) => BestAndWorstMonthModel(worstMonthRevenue: 0, bestMonthName: '', bestMonthRevenue: 0, worstMonthName: ''));
var totalRevenueProvider  = StateProvider((ref) => 0);
class CalenderChartModel {
  final String monthName;
  final double height;
  final int revenueValue;
  final List<GlobalKey> keys = List.generate(12, (index) => GlobalKey());

  CalenderChartModel(
      {required this.monthName,
      required this.height,
      required this.revenueValue});
}

class CalenderModel {
  final List<CalenderChartModel> chart;
  final List<int> leftSide;

  CalenderModel({required this.chart, required this.leftSide});
}

List<CalenderChartModel> setChartBarHeight(List<int> profitList) {
  double maxHeight = 285;
  double lowestHeight = 45;
  double lowestHeightFor = 20;

  List<CalenderChartModel> chartBarHeightList = [];

  List<double> transformedProfitList =
      profitList.map((profit) => sqrt(profit)).toList();
  double maxTransformedProfit =
      transformedProfitList.reduce((currentMax, number) {
    if (number > currentMax) {
      return number;
    } else {
      return currentMax;
    }
  });
  double lowestTransformedProfit =
      transformedProfitList.reduce((currentMin, number) {
    if (number < currentMin) {
      return number;
    } else {
      return currentMin;
    }
  });

  int lowestProfit = profitList.reduce((currentMin, number) {
    if (number < currentMin) {
      return number;
    } else {
      return currentMin;
    }
  });

  for (int idx = 0; idx < transformedProfitList.length; idx++) {
    double height = ((transformedProfitList[idx] - lowestTransformedProfit) /
            (maxTransformedProfit - lowestTransformedProfit)) *
        (maxHeight - lowestHeight);

    chartBarHeightList.add(CalenderChartModel(
        monthName: months[idx],
        revenueValue: profitList[idx],
        height: profitList[idx] != 0 && profitList[idx] == lowestProfit
            ? lowestHeightFor
            : height));
  }

  return chartBarHeightList;
}

List<int> setLeftSideChartData(List<int> data) {
  List<int> result = List.from(data);
  result.sort((a, b) => b - a);
  result.removeWhere((number) => number == 0);

  final start = result.reduce((value, element) {
    if (value < element) {
      return value;
    } else {
      return element;
    }
  });
  final end = result.reduce((value, element) {
    if (value > element) {
      return value;
    } else {
      return element;
    }
  });

  const numberOfSteps = 6;

  final step = (start - end) / (numberOfSteps - 1);

  final List<int> steps = [];

  for (int i = 0; i < numberOfSteps; i++) {
    final value = (start - (step * i)).toInt();
    steps.add(value);
  }

  steps.sort((a, b) => b - a);

  return steps;
}

var chartProfitProvider =
    FutureProvider((ref) => getProfit(ref.watch(yearProvider)));
Future<CalenderModel> getProfit(int year) async {
  List<int> profit = [];
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 1, 1), DateTime(year, 1, 31))
      .then((value) => profit.insert(0, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 2, 1), DateTime(year, 2, 29))
      .then((value) => profit.insert(1, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 3, 1), DateTime(year, 3, 31))
      .then((value) => profit.insert(2, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 4, 1), DateTime(year, 4, 30))
      .then((value) => profit.insert(3, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 5, 1), DateTime(year, 5, 31))
      .then((value) => profit.insert(4, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 6, 1), DateTime(year, 6, 30))
      .then((value) => profit.insert(5, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 7, 1), DateTime(year, 7, 31))
      .then((value) => profit.insert(6, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 8, 1), DateTime(year, 8, 31))
      .then((value) => profit.insert(7, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 9, 1), DateTime(year, 9, 30))
      .then((value) => profit.insert(8, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 10, 1), DateTime(year, 10, 31))
      .then((value) => profit.insert(9, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 11, 1), DateTime(year, 11, 30))
      .then((value) => profit.insert(10, value ?? 0));
  await GymStatusManager()
      .getMonthlyProfit(DateTime(year, 12, 1), DateTime(year, 12, 31))
      .then((value) {


    return profit.insert(11, value ?? 0);
  });

  return CalenderModel(
      chart: setChartBarHeight(profit), leftSide: setLeftSideChartData(profit));
}

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  double leftProfitPosition = -300;
  double topPosition = -100;
  int currentRevenue = 0;
  String currentMonth = "";
  final GlobalKey widgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: MouseRegion(
        onHover: (event) {
          if (event.position < const Offset(900, 513.6)) {
            setState(() {
              topPosition = -100;
              leftProfitPosition = -100;
            });
          }
        },
        child: SizedBox(
          height: 330,
          width: 470,
          child: Center(
            child: Consumer(builder: (context, ref, child) {
              var setBestAndWorstMonthProvider = ref.read(bestAndWorstMonthProvider.notifier);
              var futureData = ref.watch(chartProfitProvider);
              var setTotalRevenue = ref.read(totalRevenueProvider.notifier);

              getLowestAndBiggestRevenues(List<CalenderChartModel> list){
                int biggestRevenue = 0;
                int lowestRevenue = 9999999999999999;
                int biggestMonthIndex = 0;
                int lowestMonthIndex = 0;
                int total = 0;
                for(int idx = 0; idx< list.length;idx++){
                  total += list[idx].revenueValue;
                  int current = list[idx].revenueValue;
                  if (current > biggestRevenue){
                    biggestMonthIndex = idx;
                    biggestRevenue = current;
                  }if (current < lowestRevenue && idx < DateTime.now().month){
                    lowestMonthIndex = idx;
                    lowestRevenue = current;
                  }
                }


                Future.delayed(Duration.zero,()async{
                  setTotalRevenue.state = total;
                  setBestAndWorstMonthProvider.state = BestAndWorstMonthModel(worstMonthName: longMonths[lowestMonthIndex], worstMonthRevenue: lowestRevenue, bestMonthName: longMonths[biggestMonthIndex], bestMonthRevenue: biggestRevenue);
                });
              }
              return futureData.when(
                  data: (snapshot) {
                    if (snapshot.chart.isNotEmpty) {

                      Future.delayed(Duration.zero,(){
                        getLowestAndBiggestRevenues(snapshot.chart);
                      });


                      return Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                height: 265,
                                width: 45,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Color.fromRGBO(
                                                  45, 45, 45, 1.0)))),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ...snapshot.leftSide
                                            .map((e) => Text(e.toString()))
                                            .toList(),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          //bottom border
                          const Positioned(
                            left: 59,
                            bottom: 20,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Color.fromRGBO(
                                                45, 45, 45, 1.0)))),
                                child: SizedBox(
                                  width: 350,
                                  height: 10,
                                )),
                          ),
                          // chart bar and month name
                          Positioned(
                              left: 55,
                              bottom: 6,
                              child: LayoutBuilder(
                                key: widgetKey,
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return SizedBox(
                                      height: 290,
                                      width: 365,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: snapshot.chart.map(
                                            (e) {
                                              int idx =
                                                  snapshot.chart.indexOf(e);
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  MouseRegion(
                                                    onHover: (event) {
                                                      RenderBox box = e
                                                              .keys[idx]
                                                              .currentContext!
                                                              .findRenderObject()
                                                          as RenderBox;
                                                      final position =
                                                          box.localToGlobal(
                                                              Offset.zero);
                                                      setState(() {
                                                        topPosition =
                                                            e.height < 220
                                                                ? e.height + 40
                                                                : e.height - 10;
                                                        currentRevenue =
                                                            e.revenueValue;
                                                        currentMonth =
                                                            e.monthName;
                                                        if(idx <  (snapshot.chart.length / 2)){
                                                          leftProfitPosition = position
                                                              .dx -
                                                              (MediaQuery.sizeOf(
                                                                  context)
                                                                  .width *
                                                                  0.64);
                                                        } else{
                                                          leftProfitPosition = position
                                                              .dx -
                                                              (MediaQuery.sizeOf(
                                                                  context)
                                                                  .width *
                                                                  0.69);
                                                        }

                                                      });
                                                    },
                                                    child: LayoutBuilder(
                                                      key: e.keys[idx],
                                                      builder:
                                                          (BuildContext context,
                                                              BoxConstraints
                                                                  constraints) {
                                                        return Card(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          2),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          2),
                                                                  bottomLeft:
                                                                      Radius
                                                                          .zero,
                                                                  bottomRight:
                                                                      Radius
                                                                          .zero),
                                                          margin:
                                                              EdgeInsets.zero,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors.green,
                                                          child: SizedBox(
                                                            height:
                                                                e.height + 2,
                                                            width: 10,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(e.monthName),
                                                ],
                                              );
                                            },
                                          ).toList()));
                                },
                              )),
                          // chart revenue cursor
                          Positioned(
                              left: leftProfitPosition,
                              bottom: topPosition,
                              child: Card(
                                backgroundColor:
                                    const Color.fromRGBO(28, 26, 26, 1.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          FluentIcons.info,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text("Revenue for month $currentMonth"),
                                      ],
                                    ),
                                    Text(
                                      currentRevenue.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                  error: (err, state) {
                    return Text(err.toString());
                  },
                  loading: () => const Center(
                        child: ProgressRing(),
                      ));
            }),
          ),
        ),
      ),
    );
  }
}
