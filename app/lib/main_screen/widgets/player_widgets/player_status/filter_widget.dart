import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/subscriptions/subscriptions_information_manager.dart';
import 'package:gym_management/main_screen/widgets/combo_box_widget.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_status/player_status_widget.dart';
import '../../../../database_management/tables/teams/teams_database_manager.dart';
import 'filter_element.dart';

class FilterNotifier extends StateNotifier<Map<String, dynamic>> {
  FilterNotifier() : super({
    'gender':{"id":null,"title":"All"},
    'coach':{"id":null,'title':"All"},
    'duration':{'id':DurationTime(begDate: DateTime.now().subtract(const Duration(days: 1)),endDate: DateTime.now()) ,'title':"Today"},
    'subscription':{'id':null,'title':"All"},
  });

  void setCoachId(CustomBoxData coach) {
    state = {...state, 'coach':{"id":coach.id,'title':coach.title},};
  }

  void setDuration( DurationModel val){
    state={...state, 'duration': {'id':val.value,"title":val.title}
    };
  }
  void setGender(CustomBoxData gender){
    state={...state,'gender': {"id":gender.id, "title":gender.title}
    };
  }
  void setSubscription(CustomBoxData sub){
    state={...state,"subscription":{'id':sub.id,'title':sub.title}};
  }
}

final filterNewProvider = StateNotifierProvider<FilterNotifier, Map<String, dynamic>>(
      (ref) => FilterNotifier(),
);
final emptyProvider = StateProvider(
      (ref) => null
);
final reSubscriptionProvider = StateProvider<String>(
      (ref) => "0",
);

final filterEndedProvider = StateNotifierProvider<FilterNotifier, Map<String, dynamic>>(
      (ref) => FilterNotifier(),
);


class FilterWidget extends StatelessWidget {
  final StateNotifierProvider<FilterNotifier, Map<String, dynamic>> provider;
  const FilterWidget( {super.key,required this.provider});

  @override
  Widget build(BuildContext context) {
    return Expander(

      header: const Text("Filter by"), content:

         Column(
    children:[
      Consumer(

          builder: (context, ref,child) {

            var setFilter = ref.read(provider.notifier);

            return Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [


                FilterElement(future:SubscriptionInformationManager().getAllSubscriptionsOrdered(), title: 'Subscription value', list: null, allButton: true, isSubscription: true, onChange: (val) {

                  setFilter.setSubscription(val =="null"?CustomBoxData(title: "All", id:null ): CustomBoxData(title: val.title, id:val.id ));
                }, provider: provider, isSubscriptionWithName: false ,),
                Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {

                   var filterValues = ref.watch(provider) ;
                  return   Text(filterValues['subscription']['title'].toString());
                },)

              ],);

          }),
      Consumer(

          builder: (context, ref,child) {

            var setFilter = ref.read(provider.notifier);

            return Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [


                FilterElement(future:null, title: 'Gender', list: genders, allButton: true, isSubscription: false, onChange: (val) {

                  setFilter.setGender(val=="null"? CustomBoxData(title: "All", id:null) : CustomBoxData(title: val.title, id: val.id) );
                }, provider: provider, isSubscriptionWithName: false,),
                Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  var filterValues = ref.watch(provider);
                  return   Text(filterValues['gender']['title'].toString());
                },)

              ],);

          }),
      Consumer(

        builder: (context, ref,child) {
          var setFilter = ref.read(provider.notifier);
          return Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [


               FilterElement(future: TeamsDatabaseManager().getAllTeams(), title: 'Coach / Team', list: null, allButton: true, isSubscription: false, onChange: (val) {

                 setFilter.setCoachId(val!="null"?CustomBoxData(title: val.title, id:val.id ):CustomBoxData(title:"All",  id:null));
                     }, provider: provider, isSubscriptionWithName: false,),
                    Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      var filterValues = ref.watch(provider);

                      return  Text(filterValues['coach']['title'].toString());
                    },)

                  ],);

             }),
      Consumer(

        builder: (context, ref,child) {
          var setFilter = ref.read(provider.notifier);
          return Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [


               FilterElement(future:null, title: 'Duration', list: durationList, allButton: false, isSubscription: false, onChange: (val) {

                 setFilter.setDuration(val.id!="null"? DurationModel(title:val.title,value:DurationTime(begDate: val.id.begDate, endDate: val.id.endDate)):DurationModel(title:"Today",value:DurationTime(begDate:  DateTime.now().subtract(const Duration(days: 1)), endDate:  DateTime.now())));
                     }, provider: provider, isSubscriptionWithName: false,),
                    Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      var filterValues = ref.watch(provider);
                     return Text(filterValues['duration']['title'].toString());

                    },)
                  ],);

             }),



              ])
        );
  }
}


