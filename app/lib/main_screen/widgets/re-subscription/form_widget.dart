import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/re-subscription/re_subscription_widget.dart';
import 'package:intl/intl.dart';

import '../../../database_management/tables/subscriptions/subscriptions_information_manager.dart';
import '../player_widgets/player_status/filter_element.dart';
import '../take_new_image_widget.dart';

class ReSubscriptionFormWidget extends StatefulWidget {
  const ReSubscriptionFormWidget({super.key});

  @override
  State<ReSubscriptionFormWidget> createState() => _ReSubscriptionFormWidgetState();
}

class _ReSubscriptionFormWidgetState extends State<ReSubscriptionFormWidget> {
  TextEditingController _beginDateController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  double billValue = 0;
  @override
  Widget build(BuildContext context) {
    return   Expanded(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _key,
        child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text("Re-subscription form",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text("New duration"),
          FilterElement(isSubscriptionWithName: true, onChange: (val){
            setState(() {
              billValue = double.parse(val.id.toString());
            });

          }, isSubscription: true, allButton: false, future: SubscriptionInformationManager().getAllSubscriptions(), title: '', list: null, provider: null)
          ,Divider()
          , Text("Subscription beginning date"),
          SizedBox(height: 10,),
          Consumer(

            builder: (context, ref,child) {
              var lastSeenPlayerDate = ref.watch(playerLastSeenProvider);
              Future.delayed(Duration.zero,(){
                _beginDateController.text =DateTime.now().difference(lastSeenPlayerDate!).inDays <= 2? DateFormat.yMMMEd().format(lastSeenPlayerDate!): DateFormat.yMMMEd().format(DateTime.now());
              });

              print(lastSeenPlayerDate);
              return TextFormBox(
                readOnly: true,
                controller: _beginDateController,);
            }
          ),
          SizedBox(height: 10,),


          SizedBox(height: 10,)

          , Text("pay amount"),
          SizedBox(height: 10,),
          NumberFormBox(value: billValue,initialValue: billValue.toString(),),
          SizedBox(height: 10,)

          , Text("collector id"),
          SizedBox(height: 10,),
          TextFormBox(),
          SizedBox(height: 10,)
          ,Divider(),
          SizedBox(height: 10,),



      SizedBox(height: 10,),
          Text("Bill image"),

        const  TakeNewImageWidget(path: "re-subscription_images",),
        Consumer(
            builder: (context, ref,child) {
              XFile? image = ref.watch(imageProvider);
              return FilledButton(child: Text("Re-subscribe"), onPressed:  ()async{
                if(_key.currentState!.validate() && image != null){

                  // PlayersSubscriptionsCompanion data = PlayersSubscriptionsCompanion.insert(
                  //     teamId: teamId, subscriptionPayDate: subscriptionPayDate,
                  //     playerSubscriptionId: playerSubscriptionId, beginningDate: beginningDate,
                  //     endDate: endDate, billId: billId, billValue: billValue, duration: duration,
                  //     billCollector: billCollector);
                 // PlayersDatabaseManager().reSubscribePlayer(data);
                }
              });
            }
          )
        ],
      ),),
    ));
  }
}
