import 'package:fluent_ui/fluent_ui.dart';


Future showPriceListWidget(context) async{
  await showGeneralDialog(context: context, pageBuilder: (context,animation,animation2)=>const PriceListWidget());
}
class PriceListWidget extends StatelessWidget {
  const PriceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(child: Center(child: SizedBox(width: 400,height: 600,child: Card(backgroundColor: Colors.black,child: Column(children: [Text("sf")],),),),),);
  }
}
