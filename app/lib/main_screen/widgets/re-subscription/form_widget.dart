import 'package:fluent_ui/fluent_ui.dart';

import '../../../database_management/tables/subscriptions/subscriptions_information_manager.dart';
import '../player_widgets/player_status/filter_element.dart';
import '../take_new_image_widget.dart';

class ReSubscriptionFormWidget extends StatefulWidget {
  const ReSubscriptionFormWidget({super.key});

  @override
  State<ReSubscriptionFormWidget> createState() => _ReSubscriptionFormWidgetState();
}

class _ReSubscriptionFormWidgetState extends State<ReSubscriptionFormWidget> {
  @override
  Widget build(BuildContext context) {
    return   Expanded(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text("Re-subscription form",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
          Text("New duration"),
          FilterElement(isSubscriptionWithName: true, onChange: (val){}, isSubscription: true, allButton: false, future: SubscriptionInformationManager().getAllSubscriptions(), title: '', list: null, provider: null)
          ,Divider(),
          SizedBox(height: 10,)

          , Text("pay amount"),
          SizedBox(height: 10,),
          TextFormBox(),
          SizedBox(height: 10,)

          , Text("collector id"),
          SizedBox(height: 10,),
          TextFormBox(),
          SizedBox(height: 10,)
          ,Divider(),

      SizedBox(height: 10,),
          Text("Bill image"),

          TakeNewImageWidget(image: null),


        ],
      ),),
    ));
  }
}
