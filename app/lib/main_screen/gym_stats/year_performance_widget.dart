import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/main_screen/widgets/combo_box_widget.dart';

import 'chart_widget.dart';
List<CustomBoxData> yearList = [
  CustomBoxData(title: DateTime.now().year.toString(), id: DateTime.now().year) ,
  CustomBoxData(title:DateTime.now().subtract(const Duration(days: 365)).year.toString(),id: DateTime.now().subtract(const Duration(days: 365)).year),
  CustomBoxData(title:DateTime.now().subtract(const Duration(days: 730)).year.toString(),id: DateTime.now().subtract(const Duration(days: 730)).year),
  CustomBoxData(title:DateTime.now().subtract(const Duration(days: 1095)).year.toString(),id: DateTime.now().subtract(const Duration(days: 1095)).year),
  CustomBoxData(title:DateTime.now().subtract(const Duration(days: 1460)).year.toString(),id: DateTime.now().subtract(const Duration(days: 1460)).year),
];


StateProvider<int> yearProvider = StateProvider((ref) => DateTime.now().year);
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
           Consumer(
              builder: (context, ref,child) {
                StateController<int> year = ref.read(yearProvider.notifier);
                return ComboBoxWidget(items: yearList, filterTitle: "", onChanged: (val){
                  year.state = val.id;
                  print(val.id);
                }, allButton: false);
              }
            ),

          ],),

       const   Center(child:
              Card(child: Column(children: [
                Text("2020202",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),),
                SizedBox(height: 20,),
                Text("Total revenue"),
              ],),),)
          ,
          const Text("Year profit summary",style: TextStyle(fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 300,
                width: 640,child: Wrap(
                children: [
                  // best profit month
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
              height: 120,
              width: 300,
                    child: Card(child: ListTile(
                        leading: Icon(FluentIcons.medal_solid,color: Colors.yellow,),
                        title:const Text("March",style: TextStyle(fontSize: 19)),subtitle:  const Text("Best profit",style: TextStyle(fontSize: 14),),trailing:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(text: const TextSpan(text: "Profit: ",children: [ TextSpan(text: '23000')]),),
                        const SizedBox(height: 8,),
                        RichText(text: const TextSpan(text: "Loss: ",children: [ TextSpan(text: '13000')]),),
                        const SizedBox(height: 12,),
                        const Divider(),
                        RichText(text: const TextSpan(text: "Revenue: ",children: [ TextSpan(text: '13000')]),),
                      ],
                    ))),
                  ),
                ),
                  // worst profit month
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120,
                    width: 300,
                    child: Card(child: ListTile(
                      leading: Icon(FluentIcons.arrow_tall_down_left,color: Colors.orange,),
                      title:const Text("May",style: TextStyle(fontSize: 19)),subtitle:  const Text("least profit",style: TextStyle(fontSize: 14),),trailing:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(text: const TextSpan(text: "Profit: ",children: [ TextSpan(text: '23000')]),),
                      const SizedBox(height: 8,),
                      RichText(text: const TextSpan(text: "Loss: ",children: [ TextSpan(text: '13000')]),),
                      const SizedBox(height: 12,),
                      const Divider(),
                      RichText(text: const TextSpan(text: "Revenue: ",children: [ TextSpan(text: '13000')]),),
                    ],
                  )))),
                ),
                  //most expensive month
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 120,
                      width: 300,
                      child:  Card(child: ListTile(
                      leading: Icon(FluentIcons.warning,color: Colors.yellow,),
                      title:const Text("May"),subtitle:  const Text("expensive month"),trailing:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(text: const TextSpan(text: "Profit: ",children: [ TextSpan(text: '23000')]),),
                      const SizedBox(height: 8,),
                      RichText(text: const TextSpan(text: "Loss: ",children: [ TextSpan(text: '13000')]),),
                      const SizedBox(height: 12,),
                      const Divider(),
                      RichText(text: const TextSpan(text: "Revenue: ",children: [ TextSpan(text: '13000')]),),
                    ],
                )))),
                  ),
                  // least expensive month
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 120,
                      width: 300,
                      child:  Card(child: ListTile(
                      leading: Icon(FluentIcons.accept,color: Colors.green,),
                      title:const Text("May"),subtitle:  const Text("least expensive"),trailing:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(text: const TextSpan(text: "Profit: ",children: [ TextSpan(text: '23000')]),),
                      const SizedBox(height: 8,),
                      RichText(text: const TextSpan(text: "Loss: ",children: [ TextSpan(text: '13000')]),),
                      const SizedBox(height: 12,),
                      const Divider(),
                      RichText(text: const TextSpan(text: "Revenue: ",children: [ TextSpan(text: '13000')]),),
                    ],
                )))),
                  ),

              ],)),

            const ChartWidget()
          ],)


        ],
      ),);
  }
}
