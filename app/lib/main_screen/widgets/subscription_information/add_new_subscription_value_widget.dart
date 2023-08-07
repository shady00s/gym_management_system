import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/subscriptions/subscriptions_information_manager.dart';
import 'package:gym_management/main_screen/widgets/subscription_information/edit_subscription_info_widget.dart';

import 'create_new_subscription_widget.dart';

final listOfSubscriptionsProvider =
    StateProvider<List<SubscriptionsInfoTableData?>>((ref) => []);

class AddNewSubscriptionValueWidget extends StatefulWidget {
  const AddNewSubscriptionValueWidget({super.key});

  @override
  State<AddNewSubscriptionValueWidget> createState() =>
      _AddNewSubscriptionValueWidgetState();
}

class _AddNewSubscriptionValueWidgetState
    extends State<AddNewSubscriptionValueWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Subscription Information Manager",
                style: TextStyle(fontSize: 41, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                const CreateNewSubscriptionWidget(),
                //  current subscriptions
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Current subscription",
                        style: TextStyle(
                            fontSize: 31, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Consumer(builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        var getListOfSubscriptions =
                            ref.read(listOfSubscriptionsProvider.notifier);
                        var listOfSubscriptions =
                            ref.watch(listOfSubscriptionsProvider);

                        return SizedBox(
                            height: 450,
                            width: 400,
                            child: FutureBuilder(
                                future: SubscriptionInformationManager()
                                    .getAllSubscriptions(),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return const Center(child: ProgressBar());

                                    case ConnectionState.done:
                                      if (listOfSubscriptions.isEmpty) {
                                        Future.delayed(
                                            const Duration(seconds: 0), () {
                                          getListOfSubscriptions.state =
                                              snapshot.data!;
                                        });
                                      }

                                      if (snapshot.data!.isNotEmpty &&
                                          snapshot.hasData) {
                                        return ListView.builder(
                                            itemCount:
                                                listOfSubscriptions.length,
                                            itemBuilder: (context, index) =>
                                                SubscriptionCard(
                                                    data: listOfSubscriptions[
                                                        index]!));
                                      } else {
                                        return Center(
                                          child: Text("No subscriptions found"),
                                        );
                                      }

                                    default:
                                      return const Center(child: ProgressBar());
                                  }
                                }));
                      })
                    ],
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

