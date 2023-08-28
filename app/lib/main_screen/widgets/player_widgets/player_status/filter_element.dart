import 'package:fluent_ui/fluent_ui.dart';

import '../../combo_box_widget.dart';

class FilterElement extends StatelessWidget {
  final Future? future;

  final String title;
  final bool allButton;
  final List<dynamic>? list;
  final bool isSubscription;
  final Function onChange;
  final dynamic provider;
  final bool isSubscriptionWithName;

  const FilterElement({super.key,required this.isSubscriptionWithName,required this.onChange,required this.isSubscription,required this.allButton,required this.future,required this.title,required this.list,required this.provider});

  @override
  Widget build(BuildContext context) {
    return future !=null? FutureBuilder(
        future:future,
        builder: (context,snapshot){

          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return const Center(child: ProgressRing(),);
            case ConnectionState.done:
              return
                 snapshot.data!.length == 0? const Center(child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("No subscription data found"),
                )):snapshot.hasData ?
                 ComboBoxWidgetForFilter(

                   items:snapshot.data!.map((e)=> CustomBoxData(title:isSubscriptionWithName?e.subscriptionName:isSubscription? e.subscriptionValue.toString() : e.teamName , id:isSubscription?e.subscriptionValue:  e.teamId )).toList()

                   ,filterTitle: title,
                   onChanged:(val){onChange(val);}  , allButton: allButton, provider: provider, isSubscriptionWithName: isSubscriptionWithName,

                 ):
                const Center(child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ProgressRing(),
                ));
            default:
              return const Center(child: ProgressRing(),);
          }
        }


    ):   ComboBoxWidgetForFilter(

      items: list!.map((e)=> CustomBoxData(title: e.title  , id: e.value)).toList(),
      filterTitle: title,
      onChanged: onChange, allButton: allButton, provider: provider, isSubscriptionWithName: isSubscriptionWithName,

    );
  }
}