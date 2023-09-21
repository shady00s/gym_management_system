import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/view/widgets/player_widgets/add_new_player.dart';

import '../../../database_management/tables/generate_table.dart';
import '../../../database_management/tables/subscriptions/subscriptions_information_manager.dart';
import '../../../database_management/tables/teams/teams_database_manager.dart';
import 'add_new_subscription_value_widget.dart';

class CreateNewSubscriptionWidget extends StatefulWidget {
  const CreateNewSubscriptionWidget({super.key});

  @override
  State<CreateNewSubscriptionWidget> createState() =>
      _CreateNewSubscriptionWidgetState();
}

var getTeamsProvider = FutureProvider<List<TeamsDataTableData>>(
    (ref) => TeamsDatabaseManager().getAllTeams());
var teamProvider = StateProvider<TeamsDataTableData?>((ref) => null);

class _CreateNewSubscriptionWidgetState
    extends State<CreateNewSubscriptionWidget> {
  final TextEditingController _subName = TextEditingController();
  SubscriptionsInfoTableData subData = const SubscriptionsInfoTableData(
      subscriptionName: "",
      subscriptionValue: 0,
      subscriptionDuration: 0,
      subscriptionFreezeLimit: 0,
      subscriptionInvitationLimit: 0,
      teamId: 0);

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
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.65,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add new subscription",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[50]),
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
                                    subscriptionValue:
                                        subData.subscriptionValue,
                                    subscriptionDuration:
                                        subData.subscriptionDuration,
                                    subscriptionFreezeLimit:
                                        subData.subscriptionFreezeLimit,
                                    subscriptionInvitationLimit:
                                        subData.subscriptionInvitationLimit,
                                    teamId: subData.teamId);
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
                                        subscriptionName:
                                            subData.subscriptionName,
                                        subscriptionValue:
                                            subData.subscriptionValue,
                                        subscriptionDuration: val!,
                                        subscriptionFreezeLimit:
                                            subData.subscriptionFreezeLimit,
                                        subscriptionInvitationLimit:
                                            subData.subscriptionInvitationLimit,
                                        teamId: subData.teamId);
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
                                        subscriptionName:
                                            subData.subscriptionName,
                                        subscriptionValue: val!,
                                        subscriptionDuration:
                                            subData.subscriptionDuration,
                                        subscriptionFreezeLimit:
                                            subData.subscriptionFreezeLimit,
                                        subscriptionInvitationLimit:
                                            subData.subscriptionInvitationLimit,
                                        teamId: subData.teamId);
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
                                value: subData.subscriptionFreezeLimit,
                                onChanged: (val) {
                                  setState(() {
                                    subData = SubscriptionsInfoTableData(
                                        subscriptionName:
                                            subData.subscriptionName,
                                        subscriptionValue:
                                            subData.subscriptionValue,
                                        subscriptionDuration:
                                            subData.subscriptionDuration,
                                        subscriptionFreezeLimit: val!,
                                        subscriptionInvitationLimit:
                                            subData.subscriptionInvitationLimit,
                                        teamId: subData.teamId);
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
                      Row(
                        children: [
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
                                            subscriptionName:
                                                subData.subscriptionName,
                                            subscriptionValue:
                                                subData.subscriptionValue,
                                            subscriptionDuration:
                                                subData.subscriptionDuration,
                                            subscriptionFreezeLimit:
                                                subData.subscriptionFreezeLimit,
                                            subscriptionInvitationLimit: val!,
                                            teamId: subData.teamId);
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
                            width: 20,
                          ),
                          Consumer(builder: (context, ref, child) {
                            var teams = ref.watch(getTeamsProvider);
                            var setTeam = ref.read(teamProvider.notifier);
                            var teamVal = ref.watch(teamProvider);
                            return teams.when(
                                data: (data) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Select team"),
                                    ComboBox(

                                        placeholder: const Text("Select team"),
                                        value: teamVal,
                                        onChanged: (val) {
                                          setTeam.state = val;
                                        },
                                        items: data
                                            .map((e) => ComboBoxItem(
                                                value: e, child: Text(e.teamName)))
                                            .toList()),
                                  ],
                                ),
                                error: (err, state) =>
                                    const Text("Error occured"),
                                loading: () => const Center(
                                      child: ProgressBar(),
                                    ));
                          })
                        ],
                      ),
                      const SizedBox(
                        height: 41,
                      ),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          var teamVal = ref.watch(teamProvider);

                          return Button(
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("save subscription"),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate() &&
                                    teamVal != null) {
                                  setState(() {
                                    subData = SubscriptionsInfoTableData(
                                        subscriptionName:
                                            subData.subscriptionName,
                                        subscriptionValue:
                                            subData.subscriptionValue,
                                        subscriptionDuration:
                                            subData.subscriptionDuration,
                                        subscriptionFreezeLimit:
                                            subData.subscriptionFreezeLimit,
                                        subscriptionInvitationLimit:
                                            subData.subscriptionInvitationLimit,
                                        teamId: teamVal.teamId);
                                  });

                                  await SubscriptionInformationManager()
                                      .insertSubscriptionInformation(subData)
                                      .then((val) async {
                                    setState(() {
                                      subData =
                                          const SubscriptionsInfoTableData(
                                              subscriptionName: "",
                                              subscriptionValue: 0,
                                              subscriptionDuration: 0,
                                              subscriptionFreezeLimit: 0,
                                              subscriptionInvitationLimit: 0,
                                              teamId: 0);
                                    });
                                    await Future.delayed(
                                        const Duration(seconds: 0), () async {
                                      ref.invalidate(allSubscriptionsProvider);
                                    }).then((value) {
                                      showSnackbar(
                                          context,
                                          const InfoBar(
                                            content: Text(
                                                "subscription is saved to database."),
                                            title: Text("Succssess"),
                                          ));
                                    });
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
