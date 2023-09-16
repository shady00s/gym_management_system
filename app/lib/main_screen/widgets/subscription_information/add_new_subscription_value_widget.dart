import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/subscriptions/subscriptions_information_manager.dart';
import 'package:gym_management/main_screen/widgets/subscription_information/edit_subscription_info_widget.dart';

import 'create_new_subscription_widget.dart';


final allSubscriptionsProvider = FutureProvider.autoDispose<List<SubscriptionsInfoTableData>>((ref) =>  SubscriptionInformationManager()
    .getAllSubscriptions());


class AddNewSubscriptionValueWidget extends StatelessWidget {
  const AddNewSubscriptionValueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        backgroundColor: Colors.black,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Subscription Information Manager",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.yellow),
                ),
              ),
              const  Row(
                children: [
                   CreateNewSubscriptionWidget(),
                  //  current subscriptions
                  CurrentSubscriptions()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentSubscriptions extends ConsumerWidget {
  const CurrentSubscriptions({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allSubscriptions =  ref.watch(allSubscriptionsProvider);

    return Expanded(
        child: Padding(
          padding:const  EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                "Current subscription",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,color: Colors.grey[50])),

               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(
                  "See and edit all subscriptions",
                  style: TextStyle(fontSize: 14, color: Colors.grey[80])),
               ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  height: 450,
                  width: 400,
                  child: allSubscriptions.when(
                      skipLoadingOnRefresh:false,
                      data: (snapshot){

                        if(snapshot.isNotEmpty){
                          return ListView.builder(
                            itemCount: snapshot.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SubscriptionCard(data: snapshot[index]);
                            },
                          );
                        }else{
                         return const Center(child: Text("No subscriptions found"));
                        }
                      }

                        ,
                      error: (err,state)=>  const Center(child:  Text("Error occured")),
                      loading: ()=>const Center(child: ProgressBar())))
            ],
          ),
        ));
  }
}




