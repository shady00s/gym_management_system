import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/gym_status_manager.dart';
import 'package:gym_management/main_screen/widgets/combo_box_widget.dart';

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
          Text("Details",style: TextStyle(fontWeight: FontWeight.bold),),
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

class _ChartWidgetState extends State<ChartWidget> {
  @override
  void initState() {
     GymStatusManager().getYearProfit(DateTime(2022,1,1));
     GymStatusManager().getYearProfit(DateTime(2023,1,1));
     GymStatusManager().getBestMonthInProfit(DateTime(2023,1,1),DateTime(2023,1,31));

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
          Positioned(
            left: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
          bottom: 3,
          child: SizedBox(
                height:300,
                width: 370,
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:[

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('jan'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('feb'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('mar'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('apr'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('may'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('jun'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('jul'),
                        ],
                      ), Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('aug'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('sep'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('oct'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('nov'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(margin: EdgeInsets.zero,padding: EdgeInsets.zero, backgroundColor: Colors.green, child: const SizedBox(height: 200,width: 10,),),
                          SizedBox(height: 8,),
                          Text('dec'),
                        ],
                      ),

                    ]))),


          ],
        ),


      ),
    );
  }
}
