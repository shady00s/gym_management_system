import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/database_management/tables/subscriptions/subscriptions_information_manager.dart';
import 'package:gym_management/main_screen/widgets/edit_subscription_info_widget.dart';

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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Subscription Information Manager",
                style: TextStyle(fontSize: 41, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                CreateNewSubscriptionWidget(),
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

class CreateNewSubscriptionWidget extends StatefulWidget {
  const CreateNewSubscriptionWidget({super.key});

  @override
  State<CreateNewSubscriptionWidget> createState() =>
      _CreateNewSubscriptionWidgetState();
}

class _CreateNewSubscriptionWidgetState
    extends State<CreateNewSubscriptionWidget> {
  SubscriptionsInfoTableData subData = SubscriptionsInfoTableData(
      subscriptionName: "",
      subscriptionValue: 0,
      subscriptionDuration: 0,
      subscriptionFreezeLimit: 0,
      subscriptionInvitationLimit: 0);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return //create new subscription
        Form(
      key: _formKey,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Add new subscription",
                    style: TextStyle(fontSize: 31, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  SizedBox(
                      width: 220,
                      child: TextFormBox(
                        //controller: _subName,
                        placeholder: "Subscription name",
                        validator: (val) {
                          if (val == null) {
                            return "Please enter subscription name";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            subData = SubscriptionsInfoTableData(
                                subscriptionName: val,
                                subscriptionValue: subData.subscriptionValue,
                                subscriptionDuration:
                                    subData.subscriptionDuration,
                                subscriptionFreezeLimit:
                                    subData.subscriptionFreezeLimit,
                                subscriptionInvitationLimit:
                                    subData.subscriptionInvitationLimit);
                          });
                        },
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("Set subscription duration"),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      width: 220,
                      child: Row(
                        children: [
                          Expanded(
                              child: NumberFormBox(
                            value: 0,
                            onChanged: (val) {
                              setState(() {
                                subData = SubscriptionsInfoTableData(
                                    subscriptionName: subData.subscriptionName,
                                    subscriptionValue:
                                        subData.subscriptionValue,
                                    subscriptionDuration: val!,
                                    subscriptionFreezeLimit:
                                        subData.subscriptionFreezeLimit,
                                    subscriptionInvitationLimit:
                                        subData.subscriptionInvitationLimit);
                              });
                            },
                            validator: (val) {
                              if (val == null) {
                                return "Please add subscription duration";
                              }

                              return null;
                            },
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Days")
                        ],
                      )),
                  const SizedBox(
                    height: 21,
                  ),
                  Text("Set subscription value"),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      width: 220,
                      child: Row(
                        children: [
                          Expanded(
                              child: NumberFormBox(
                            value: 0,
                            onChanged: (val) {
                              setState(() {
                                subData = SubscriptionsInfoTableData(
                                    subscriptionName: subData.subscriptionName,
                                    subscriptionValue: val!,
                                    subscriptionDuration:
                                        subData.subscriptionDuration,
                                    subscriptionFreezeLimit:
                                        subData.subscriptionFreezeLimit,
                                    subscriptionInvitationLimit:
                                        subData.subscriptionInvitationLimit);
                              });
                            },
                            validator: (val) {
                              if (val == null) {
                                return "Please add subscription value";
                              }

                              return null;
                            },
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Text("LE")
                        ],
                      )),
                  const SizedBox(
                    height: 21,
                  ),
                  Text("Set freeze limit"),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      width: 220,
                      child: Row(
                        children: [
                          Expanded(
                              child: NumberFormBox(
                            value: 0,
                            onChanged: (val) {
                              setState(() {
                                subData = SubscriptionsInfoTableData(
                                    subscriptionName: subData.subscriptionName,
                                    subscriptionValue:
                                        subData.subscriptionValue,
                                    subscriptionDuration:
                                        subData.subscriptionDuration,
                                    subscriptionFreezeLimit: val!,
                                    subscriptionInvitationLimit:
                                        subData.subscriptionInvitationLimit);
                              });
                            },
                            validator: (val) {
                              if (val == null) {
                                return "Please add number invitations";
                              }

                              return null;
                            },
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Days")
                        ],
                      )),
                  const SizedBox(
                    height: 21,
                  ),
                  Text("Set number of invitations"),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      width: 220,
                      child: Row(
                        children: [
                          Expanded(
                              child: NumberFormBox(
                            value: 0,
                            onChanged: (val) {
                              setState(() {
                                subData = SubscriptionsInfoTableData(
                                    subscriptionName: subData.subscriptionName,
                                    subscriptionValue:
                                        subData.subscriptionValue,
                                    subscriptionDuration:
                                        subData.subscriptionDuration,
                                    subscriptionFreezeLimit:
                                        subData.subscriptionFreezeLimit,
                                    subscriptionInvitationLimit: val!);
                              });
                            },
                            validator: (val) {
                              if (val == null) {
                                return "Please add number invitations";
                              }

                              return null;
                            },
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Invitations")
                        ],
                      )),
                  const SizedBox(
                    height: 41,
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      var listOfSubscriptions =
                          ref.watch(listOfSubscriptionsProvider);

                      var getListOfSubscriptions =
                          ref.read(listOfSubscriptionsProvider.notifier);

                      return Button(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("save subscription"),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await SubscriptionInformationManager()
                                  .insertSubscriptionInformation(subData)
                                  .then((val) async {
                                await Future.delayed(const Duration(seconds: 0),
                                    () async {
                                  getListOfSubscriptions.state =
                                      await SubscriptionInformationManager()
                                          .getAllSubscriptions();
                                }).then((value) => showSnackbar(
                                    context,
                                    InfoBar(
                                      content: Text(
                                          "subscription is saved to database."),
                                      title: Text("Succssess"),
                                    )));
                              });
                            }
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
