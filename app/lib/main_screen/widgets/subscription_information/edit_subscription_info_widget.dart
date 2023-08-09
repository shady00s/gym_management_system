
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/main_screen/widgets/subscription_information/add_new_subscription_value_widget.dart';

import '../../../database_management/tables/generate_table.dart';
import '../../../database_management/tables/subscriptions/subscriptions_information_manager.dart';

class SubscriptionCard extends StatefulWidget {
  final SubscriptionsInfoTableData data;
  const SubscriptionCard({super.key, required this.data});

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _subName = TextEditingController();

  SubscriptionsInfoTableData? editSubData;
  @override
  void initState() {

      setState(() {
        editSubData = widget.data;
        _subName.text = editSubData!.subscriptionName;
      });


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Consumer(

          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var getListOfSubscriptions  = ref.read(listOfSubscriptionsProvider.notifier);
            return Button(
                onPressed: () async {

                  await showDialog(
                      context: context,
                      builder: (context) => ContentDialog(
                          title: Text("Subscription info"),
                          content: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                            editSubData = SubscriptionsInfoTableData(
                                                id: widget.data.id,
                                                subscriptionName: val,
                                                subscriptionValue: editSubData!
                                                    .subscriptionValue,
                                                subscriptionDuration: editSubData!
                                                    .subscriptionDuration,
                                                subscriptionFreezeLimit:
                                                editSubData!
                                                    .subscriptionFreezeLimit,
                                                subscriptionInvitationLimit:
                                                editSubData!
                                                    .subscriptionInvitationLimit);
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
                                                initialValue: editSubData!.subscriptionDuration.toString(),
                                                value:
                                                editSubData!.subscriptionDuration,
                                                onChanged: (val) {
                                                  setState(() {
                                                    editSubData = SubscriptionsInfoTableData(
                                                        id: widget.data.id,
                                                        subscriptionName: editSubData!
                                                            .subscriptionName,
                                                        subscriptionValue:
                                                        editSubData!
                                                            .subscriptionValue,
                                                        subscriptionDuration: val!,
                                                        subscriptionFreezeLimit:
                                                        editSubData!
                                                            .subscriptionFreezeLimit,
                                                        subscriptionInvitationLimit:
                                                        editSubData!
                                                            .subscriptionInvitationLimit);
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
                                                initialValue: editSubData!.subscriptionValue.toString(),
                                                value: editSubData!.subscriptionValue,
                                                onChanged: (val) {
                                                  setState(() {

                                                    editSubData = SubscriptionsInfoTableData(
                                                        id: widget.data.id,

                                                        subscriptionName: editSubData!
                                                            .subscriptionName,
                                                        subscriptionValue: val!,
                                                        subscriptionDuration:
                                                        editSubData!
                                                            .subscriptionDuration,
                                                        subscriptionFreezeLimit:
                                                        editSubData!
                                                            .subscriptionFreezeLimit,
                                                        subscriptionInvitationLimit:
                                                        editSubData!
                                                            .subscriptionInvitationLimit);
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
                                                initialValue:  editSubData!
                                                    .subscriptionFreezeLimit.toString(),
                                                value: editSubData!
                                                    .subscriptionFreezeLimit,
                                                onChanged: (val) {
                                                  setState(() {
                                                    editSubData = SubscriptionsInfoTableData(
                                                        id: widget.data.id,
                                                        subscriptionName: editSubData!
                                                            .subscriptionName,
                                                        subscriptionValue:
                                                        editSubData!
                                                            .subscriptionValue,
                                                        subscriptionDuration:
                                                        editSubData!
                                                            .subscriptionDuration,
                                                        subscriptionFreezeLimit: val!,
                                                        subscriptionInvitationLimit:
                                                        editSubData!
                                                            .subscriptionInvitationLimit);
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
                                                initialValue:  editSubData!
                                                    .subscriptionInvitationLimit.toString() ,
                                                value: editSubData!
                                                    .subscriptionInvitationLimit,
                                                onChanged: (val) {
                                                  setState(() {
                                                    editSubData = SubscriptionsInfoTableData(
                                                        id: widget.data.id,
                                                        subscriptionName: editSubData!
                                                            .subscriptionName,
                                                        subscriptionValue:
                                                        editSubData!
                                                            .subscriptionValue,
                                                        subscriptionDuration:
                                                        editSubData!
                                                            .subscriptionDuration,
                                                        subscriptionFreezeLimit:
                                                        editSubData!
                                                            .subscriptionFreezeLimit,
                                                        subscriptionInvitationLimit:
                                                        val!);
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
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Button(
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("update subscription"),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              await SubscriptionInformationManager()
                                                  .editSubscriptionData(
                                                  widget.data.id!,
                                                  editSubData!)
                                                  .then((val) async {
                                                await Future.delayed(const Duration(seconds: 0),() async {
                                                  getListOfSubscriptions.state = await SubscriptionInformationManager().getAllSubscriptions();
                                                });



                                                showSnackbar(
                                                    context,
                                                    InfoBar(
                                                      content: Text(
                                                          "subscription is saved to database."), title: Text("Succssess"),));
                                              }).then((value){

                                                Navigator.pop(context);
                                              });

                                            }
                                          }),



                                      Button(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Cancel"),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.data.subscriptionName),
                      IconButton(icon: Icon(FluentIcons.delete), onPressed: () async{
                        showDialog(context: context, builder: (context)=>ContentDialog(title: Text("Delete subscription information"),content: Text("Are you sure you want to delete this subscripton information?"),

                          actions: [
                            Button(child:  Text("Delete"), onPressed: ()async{
                              await SubscriptionInformationManager().deleteSubscriptionData(widget.data.id!).then((value) async => getListOfSubscriptions.state = await SubscriptionInformationManager().getAllSubscriptions());

                              showSnackbar(context, InfoBar(title: Text("Succssess"),content: Text("Subscription is successfully deleted"),));
                              Navigator.pop(context);

                            }),
                            FilledButton(child: Text("Cancel"), onPressed: (){
                              Navigator.pop(context);
                            })
                          ],

                        ));


                      })
                    ],
                  ),
                ));
          },
        ));
  }
}