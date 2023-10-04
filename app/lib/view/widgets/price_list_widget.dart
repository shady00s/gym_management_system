import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/database_management/tables/subscriptions/subscriptions_information_manager.dart';
import '../../database_management/models/subscriptions_with_team_model.dart';


Future showPriceListWidget(context) async{
  await showGeneralDialog(context: context, pageBuilder: (context,animation,animation2)=>const PriceListWidget());
}
Random rand1 = Random();
Random rand2 = Random();
Random rand3 = Random();

class PriceListWidget extends StatelessWidget {
  const PriceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(child: Center(child: SizedBox(width: MediaQuery.sizeOf(context).width * 0.93,height: 600,child: Card(backgroundColor: Colors.black,child: Column(children: [

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Price List",style: TextStyle(fontSize: 21,color: Colors.yellow,fontWeight: FontWeight.bold),),
          IconButton(onPressed: () {
                    Navigator.of(context).pop();
                },
                  icon:const Icon(FluentIcons.cancel),


          )
        ],
      ),

    // price list

      FutureBuilder<List<SubscriptionsWithTeamModel>>(future: SubscriptionInformationManager().getAllSubscriptionsInformation(),
        builder: (BuildContext context, AsyncSnapshot<List<SubscriptionsWithTeamModel>> snapshot) {

            switch(snapshot.connectionState){
              case ConnectionState.done:
                if(snapshot.hasData) {
                  return  Expanded(

                  child:Wrap(
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      children: snapshot.data!.map((e)
                      {
                        int redVal = rand1.nextInt(28) + 12;
                        int blueVal = rand2.nextInt(28)+ 12;
                        int greenVal = rand3.nextInt(28)+ 12;
                       return Padding(
                                    padding:
                                        const EdgeInsets.all(8.0),
                                    child: Card(
                                      backgroundColor: Color.fromRGBO(
                                          redVal, blueVal, greenVal , 1),
                                      child: SizedBox(
                                        width: 271,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          children: [
                                            Text(
                                              e.subName,
                                              style: const TextStyle(
                                                  fontSize: 21,
                                                  fontWeight:
                                                      FontWeight
                                                          .bold),
                                            ),
                                            const SizedBox(
                                              height: 35,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  "Subscription value:",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey[80]),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 140,
                                                    ),
                                                    Text(
                                                      "${e.subValue} LE",
                                                      style: const TextStyle(
                                                          fontSize:
                                                              18,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 35,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  "Subscription duration:",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey[80]),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 140,
                                                    ),
                                                    Text(
                                                      "${e.subDuration} days",
                                                      style: const TextStyle(
                                                          fontSize:
                                                              18,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 19,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  "Subscription freeze:",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey[80]),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 140,
                                                    ),
                                                    Text(
                                                      "${e.subFreeze} days",
                                                      style: const TextStyle(
                                                          fontSize:
                                                              18,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 19,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  "Subscription invitations:",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey[80]),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 140,
                                                    ),
                                                    Text(
                                                      "${e.subInvitation} invitations",
                                                      style: const TextStyle(
                                                          fontSize:
                                                              18,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 19,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  "Subscription team:",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey[80]),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 140,
                                                    ),
                                                    Text(
                                                      e.teamName,
                                                      style: const TextStyle(
                                                          fontSize:
                                                              18,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 19,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  "Private feeze:",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey[80]),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 140,
                                                    ),
                                                    Text(
                                                      "${e.subFreeze} days",
                                                      style: const TextStyle(
                                                          fontSize:
                                                              18,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                    }).toList())

            );
                }
                return const SizedBox();
              case ConnectionState.none:
                return const Text("Error occured");
              case ConnectionState.active:
              case ConnectionState.waiting:
                return const Expanded(child: Center(child: ProgressRing(),));
          }

        },)
    ],),),),),);
  }
}
