import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database_management/tables/generate_table.dart';
import '../../../database_management/tables/subscriptions/subscriptions_information_manager.dart';
import 'add_new_subscription_value_widget.dart';

class CreateNewSubscriptionWidget extends StatefulWidget {
  const CreateNewSubscriptionWidget({super.key});

  @override
  State<CreateNewSubscriptionWidget> createState() =>
      _CreateNewSubscriptionWidgetState();
}

class _CreateNewSubscriptionWidgetState
    extends State<CreateNewSubscriptionWidget> {
  final TextEditingController _subName = TextEditingController();
  SubscriptionsInfoTableData subData = const SubscriptionsInfoTableData(
      subscriptionName: "",
      subscriptionValue: 0,
      subscriptionDuration: 0,
      subscriptionFreezeLimit: 0,
      subscriptionInvitationLimit: 0, teamId: 0);

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
                child:  SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.35,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "Add new subscription",
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,color: Colors.grey[50]),
                          ),
                          const SizedBox(
                            height: 31,
                          ),
                          SizedBox(
                              width: 220,
                              child: TextFormBox(
                                controller: _subName,

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
                                        subData.subscriptionInvitationLimit, teamId: 0);
                                  });
                                },
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text("Set subscription duration"),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                              width: 220,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: NumberFormBox(
                                        value: subData.subscriptionDuration,
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
                                                subData.subscriptionInvitationLimit, teamId: 0);
                                          });
                                        },
                                        validator: (val) {
                                          if (val == null) {
                                            return "Please add subscription duration";
                                          }

                                          return null;
                                        },
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text("Days")
                                ],
                              )),
                          const SizedBox(
                            height: 21,
                          ),
                          const Text("Set subscription value"),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                              width: 220,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: NumberFormBox(
                                        value: subData.subscriptionValue,
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
                                                subData.subscriptionInvitationLimit, teamId: 0);
                                          });
                                        },
                                        validator: (val) {
                                          if (val == null) {
                                            return "Please add subscription value";
                                          }

                                          return null;
                                        },
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text("LE")
                                ],
                              )),
                          const SizedBox(
                            height: 21,
                          ),
                          const Text("Set freeze limit"),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                              width: 220,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: NumberFormBox(
                                        value:subData.subscriptionFreezeLimit,
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
                                                subData.subscriptionInvitationLimit, teamId: 0);
                                          });
                                        },
                                        validator: (val) {
                                          if (val == null) {
                                            return "Please add number invitations";
                                          }

                                          return null;
                                        },
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text("Days")
                                ],
                              )),
                          const SizedBox(
                            height: 21,
                          ),
                          const Text("Set number of invitations"),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                              width: 220,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: NumberFormBox(
                                        value: subData.subscriptionInvitationLimit,
                                        onChanged: (val) {
                                          setState(() {
                                            _subName.text = "";
                                            subData = SubscriptionsInfoTableData(
                                                subscriptionName: subData.subscriptionName,
                                                subscriptionValue:
                                                subData.subscriptionValue,
                                                subscriptionDuration:
                                                subData.subscriptionDuration,
                                                subscriptionFreezeLimit:
                                                subData.subscriptionFreezeLimit,
                                                subscriptionInvitationLimit: val!, teamId: 0);
                                          });
                                        },
                                        validator: (val) {
                                          if (val == null) {
                                            return "Please add number invitations";
                                          }

                                          return null;
                                        },
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text("Invitations")
                                ],
                              )),
                          const SizedBox(
                            height: 41,
                          ),
                          Consumer(
                            builder:
                                (BuildContext context, WidgetRef ref, Widget? child) {



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

                                        setState(() {
                                          subData = const SubscriptionsInfoTableData(
                                              subscriptionName: "",
                                              subscriptionValue: 0,
                                              subscriptionDuration: 0,
                                              subscriptionFreezeLimit: 0,
                                              subscriptionInvitationLimit: 0, teamId: 0);
                                        });
                                        await Future.delayed(const Duration(seconds: 0),
                                                () async {
                                               ref.invalidate(allSubscriptionsProvider);


                                            }).then((value)
                                            {

                                        showSnackbar(
                                        context,
                                        const InfoBar(
                                        content: Text(
                                        "subscription is saved to database."),
                                        title: Text("Succssess"),
                                        ));
                                            }


                                        );
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
            ),
          ),

      );
  }
}
