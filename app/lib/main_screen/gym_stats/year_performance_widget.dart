import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/gym_status_manager.dart';
import 'package:gym_management/main_screen/widgets/combo_box_widget.dart';
import 'dart:math';
List<CustomBoxData> yearList = [
  CustomBoxData(title: DateTime.now().year.toString(), id: DateTime.now().year) ,
  CustomBoxData(title:DateTime.now().subtract(Duration(days: 365)).year.toString(),id: DateTime.now().subtract(Duration(days: 365)).year),
  CustomBoxData(title:DateTime.now().subtract(Duration(days: 730)).year.toString(),id: DateTime.now().subtract(Duration(days: 730)).year),
  CustomBoxData(title:DateTime.now().subtract(Duration(days: 1095)).year.toString(),id: DateTime.now().subtract(Duration(days: 1095)).year),
  CustomBoxData(title:DateTime.now().subtract(Duration(days: 1460)).year.toString(),id: DateTime.now().subtract(Duration(days: 1460)).year),
];

class YearPerformanceWidget extends StatelessWidget {
  const YearPerformanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(child:

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const   Padding(
              padding:  EdgeInsets.all(12.0),
              child: Text("Year performance",style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
            ),
            ComboBoxWidget(items: yearList, filterTitle: "", onChanged: (val){}, allButton: false),

          ],),

       const   Center(child:
              Card(child: Column(children: [
                Text("2020202",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),),
                SizedBox(height: 20,),
                Text("Total revenue"),
              ],),),)
          ,
          Text("Year summary",style: TextStyle(fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 300,
                width: 300,child: Column(children: [
                SizedBox(height: 10,),
                Card(child: ListTile(
                    leading: Icon(FluentIcons.medal_solid),
                    title:Text("March"),subtitle:  Text("Best month"),trailing:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(text: "Profit: ",children: [ TextSpan(text: '23000')]),),
                    SizedBox(height: 8,),
                    RichText(text: TextSpan(text: "Loss: ",children: [ TextSpan(text: '13000')]),),
                    SizedBox(height: 12,),
                    Divider(),
                    RichText(text: TextSpan(text: "Revenue: ",children: [ TextSpan(text: '13000')]),),
                  ],
                )))
                ,


                SizedBox(height: 10,),
                Card(child: ListTile(
                    leading: Icon(FluentIcons.arrow_tall_down_left),
                    title:Text("May"),subtitle:  Text("least month"),trailing:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(text: "Profit: ",children: [ TextSpan(text: '23000')]),),
                    SizedBox(height: 8,),
                    RichText(text: TextSpan(text: "Loss: ",children: [ TextSpan(text: '13000')]),),
                    SizedBox(height: 12,),
                    Divider(),
                    RichText(text: TextSpan(text: "Revenue: ",children: [ TextSpan(text: '13000')]),),
                  ],
                ))),

              ],),
            ),
            ChartWidget()
          ],)


        ],
      ),);
  }
}
class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});


  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}
List<String> months = ['Jan','Feb','March','Apr','Jun','Jul',"Aug","Sep",'Oct','Nov','Dec'];
class CalenderChartModel{
  final String monthName;
  final double value;

  CalenderChartModel({required this.monthName, required this.value});
}

 List<CalenderChartModel> setChartBarHeight(List<int> profitList){
  double maxHeight = 240;
  double lowestHeight = 30 ;

   List<CalenderChartModel> chartBarHeightList =[];
  List<double> transformedProfitList = profitList.map((profit) => sqrt(profit)).toList();

  double maxTransformedProfit = transformedProfitList.reduce((currentMax, number) {
    if (number > currentMax) {
      return number;
    } else {
      return currentMax;
    }
  });

  double lowestTransformedProfit = transformedProfitList.reduce((currentMin, number) {
    if (number < currentMin) {
      return number;
    } else {
      return currentMin;
    }
  });

  for (int idx =0; idx < transformedProfitList.length; idx++) {

    double height = ((transformedProfitList[idx] - lowestTransformedProfit) /
        (maxTransformedProfit - lowestTransformedProfit)) *
        (maxHeight - lowestHeight);
    if(height !=0){
      chartBarHeightList.add(CalenderChartModel(monthName: months[idx], value: height));
    }

  }

   for(int idx =0; idx < months.length; idx++){
     if(chartBarHeightList.length < 12 && idx > chartBarHeightList.length -1 ){
       chartBarHeightList.insert(idx, CalenderChartModel(monthName: months[idx], value: 0));
     }
   }

  return chartBarHeightList;
 }

 List<int> setLeftSideChartData(List<int> data){
  List<int> result = List.from(data) ;
  result.sort((a,b)=>a-b);

      result.removeWhere((number)=>number == 0);
  return result;
}

 Future<List<CalenderChartModel>> getProfit() async{
   List<int> profit = [];
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,1,1),DateTime(2023,1,31)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,2,1),DateTime(2023,2,28)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,3,1),DateTime(2023,3,31)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,4,1),DateTime(2023,4,30)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,5,1),DateTime(2023,5,31)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,6,1),DateTime(2023,6,30)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,7,1),DateTime(2023,7,31)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,8,1),DateTime(2023,8,31)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,9,1),DateTime(2023,9,30)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,10,1),DateTime(2023,10,31)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,11,1),DateTime(2023,11,30)).then((value) => profit.add(value??0));
     await  GymStatusManager().getBestMonthInProfit(DateTime(2023,12,1),DateTime(2023,12,31)).then((value) => profit.add(value??0));

   setLeftSideChartData(profit);
     return setChartBarHeight(profit);
 }

class _ChartWidgetState extends State<ChartWidget> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 300,
        width: 500,
        child:
        Stack(
          children: [
            const  Positioned(
            left: 0,
            top: 0,
            child: Padding(
              padding:  EdgeInsets.all(12.0),
              child:  SizedBox(
                      height:260,
                      width: 45,
                      child:DecoratedBox(
                        decoration: BoxDecoration(border: Border(right: BorderSide(color: Color.fromRGBO(
                            45, 45, 45, 1.0)))),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Text('1000'),
                        Text('2000'),
                        Text('3000'),
                        Text('4000'),
                        Text('5000'),
                        Text('6000'),


                      ],),
                    ),
              ),
            ),
          ),

          Positioned(
            left: 59,
            bottom: 20,
            child: DecoratedBox(decoration:  BoxDecoration(border: Border(top: BorderSide(color: Color.fromRGBO(
                    45, 45, 45, 1.0)))),
                child:   SizedBox(width: 350,height: 10,)),
          ),
        Positioned(
          left: 55,
          bottom: 6,
          child: SizedBox(
                height:300,
                width: 370,
                child:FutureBuilder<List<CalenderChartModel>>(
                  future: getProfit(),
                  builder: (context,AsyncSnapshot<List<CalenderChartModel>> snapshot) {

                    switch(snapshot.connectionState){

                      case ConnectionState.done:
                        if(snapshot.hasData) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            crossAxisAlignment: CrossAxisAlignment.end,
                            children:
                            snapshot.data!.map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Card(
                                  borderRadius:const BorderRadius.only(topLeft:Radius.circular(2),topRight: Radius.circular(2),bottomLeft:Radius.zero,bottomRight: Radius.zero ),
                                  margin: EdgeInsets.zero
                                  ,padding: EdgeInsets.zero, backgroundColor: Colors.green, child:  SizedBox(height: e.value,width: 10,),),
                               const SizedBox(height: 8,),
                                Text(e.monthName),
                              ],
                            ),).toList()
                              );
                        }
                        return Text("err");
                        default:
                        return SizedBox();
                    }

                  }
                ))),


          ],
        ),


      ),
    );
  }
}
