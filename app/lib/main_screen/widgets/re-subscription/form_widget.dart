import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/add_new_player.dart';
import 'package:gym_management/main_screen/widgets/re-subscription/re_subscription_widget.dart';
import 'package:gym_management/manage_excel/ui_widget.dart';
import 'package:intl/intl.dart';
import '../../../database_management/tables/generate_table.dart';
import '../../../database_management/tables/players/player_database_manager.dart';
import '../../../database_management/tables/subscriptions/subscriptions_information_manager.dart';
import '../take_new_image_widget.dart';

class ReSubscriptionFormWidget extends StatefulWidget {
  final int playerIndexId;
  const ReSubscriptionFormWidget({super.key,required this.playerIndexId});

  @override
  State<ReSubscriptionFormWidget> createState() => _ReSubscriptionFormWidgetState();
}

class _ReSubscriptionFormWidgetState extends State<ReSubscriptionFormWidget> {
  final TextEditingController _beginDateController = TextEditingController();
  DateTime? customDate;
  DateTime? _beginningDate;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  double billValue = 0;
  SubscriptionsInfoTableData? subValue;
  bool isNoImage = false;
 int? billId;
 String collectorId ="";

  submitFunction(){
    setState(() {
      _beginDateController.text =  DateFormat.yMMMEd().format(customDate!);
      _beginningDate = customDate;
    });
    Navigator.pop(context);

  }
  cancelFunction(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return   Expanded(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            const Text("Re-subscription form",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            const Text("New duration"),
            // new subscription and offer id
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                FutureBuilder<List<SubscriptionsInfoTableData>>(
                 future: SubscriptionInformationManager().getAllSubscriptions(),
                  builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        return ComboBox(
                      placeholder: const ComboBoxItem(value:null,child: Text("Select subscription")),
                      value: subValue,
                      onChanged: (val){
                        setState(() {
                          subValue = val;
                        });
                      },
                      items: snapshot.data!.map((e) => ComboBoxItem(value:e,child: Text(e.subscriptionName))).toList(),);
                      }else if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: ProgressBar(),);

                      }else if( !snapshot.hasData){
                        return const Center(child: Text("No subscriptions"),);
                      }else{
                        return const Center(child: Text("No subscriptions"),);
                      }

                 }
                )
                

               , Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(width:120,child: TextFormBox(placeholder: 'Offer ID',)),
                )
              ],
            ),
          const SizedBox(height: 10,),

          const Text("Subscription beginning date"),
            const SizedBox(height: 10,),
            //subscription beg date
            Consumer(

              builder: (context, ref,child) {
                var lastSeenPlayerDate = ref.watch(playerLastSeenProvider);
                Future.delayed(Duration.zero,(){
                  if(customDate ==null) {
                    _beginDateController.text = lastSeenPlayerDate == null? DateFormat.yMMMEd().format(DateTime.now()):   DateTime.now().difference(lastSeenPlayerDate).inDays <= 2? DateFormat.yMMMEd().format(lastSeenPlayerDate): DateFormat.yMMMEd().format(DateTime.now() );
                    _beginningDate = lastSeenPlayerDate ?? DateTime.now();



                  }else{
                    _beginDateController.text = DateFormat.yMMMEd().format(customDate!);
                    _beginningDate = lastSeenPlayerDate ?? customDate;



                  }
                });

// select custom date
                return TextFormBox(

                  onTap: ()async{
                   await showDialog(context: context, builder:(context)=> StatefulBuilder(

                       builder: (context, setState) {
                       return ContentDialog(
                          title: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             const  Text("Select custom date"),
                              IconButton(icon:const Icon(FluentIcons.cancel),onPressed:(){Navigator.pop(context);})
                       ],), content: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           const Text("NOTE: system cannot accept old date"),
                           const  SizedBox(height: 12,),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: DatePicker(showYear:  false, startDate: DateTime.now(), selected: customDate,onChanged: (val){
                                  setState(() {
                                    customDate = val;
                                  });
                             },),
                           ),
                          if( customDate!= null && customDate!.difference(DateTime.now()).inDays.isNegative )
                           Text("please select date newer  date",style: TextStyle(color: Colors.red,fontSize: 19),),
                         ],
                       )
                       , actions:customDate!= null && !customDate!.difference(DateTime.now()).inDays.isNegative? [
                            FilledButton(onPressed:submitFunction, child:  const Text("submit")),
                            Button(onPressed:cancelFunction, child: const Text("cancel")),

                       ]:null,

                       );
                     }
                   ) ) ;
                  },
                  readOnly: true,
                  controller: _beginDateController,);
              }
            ),

            const SizedBox(height: 10,),
            const Text("pay amount"),
            const SizedBox(height: 10,),
            NumberFormBox(value:subValue?.subscriptionValue,initialValue: billValue.toString(),),



            const SizedBox(height: 10,)

            , const Text("collector id"),
            const SizedBox(height: 10,),
            TextFormBox(
              onChanged: (val){
                setState(() {
                  collectorId =val;
                });
              },
              validator: (val){
              if(val!.isEmpty){
                return "Please add your ID";
              }
              return null;
            },),
            const SizedBox(height: 10,)
            ,const Divider(),
            const SizedBox(height: 10,),



        const SizedBox(height: 10,),
            const Text("Bill image"),

             SizedBox(height:140,child:   TakeNewImageWidget(path: "re-subscription_images", state: billImageProvider,)),
          if(isNoImage)
             Padding(
              padding:const  EdgeInsets.all(8.0),
              child: Text('please add bill image',style: TextStyle(color: Colors.red.lighter,fontWeight: FontWeight.w500),),
            ),

            const SizedBox(height: 10,)

            , const Text("bill ID"),
            const SizedBox(height: 10,),
            NumberFormBox(
              value: billId,
              onChanged: (val){
                setState(() {
                  billId = val!;
                });
              },
              validator: (val){
              if( val == null){
                return "Please add bill ID";
              }
              return null;
            },),
            const SizedBox(height: 10,),

            Consumer(
              builder: (context, ref,child) {
               String? imagePath = ref.watch(billImageProvider);
                return FilledButton(child: const Text("Re-subscribe"), onPressed:  ()async{
                  if(imagePath == null){
                    setState(() {
                      isNoImage = true;
                    });
                  }
                  if(_key.currentState!.validate() && imagePath != null){
                    setState(() {
                      isNoImage = false;
                    });
                    PlayersSubscriptionsCompanion data = PlayersSubscriptionsCompanion.insert(
                        teamId: subValue!.teamId, subscriptionPayDate: DateTime.now(),
                        playerSubscriptionId: widget.playerIndexId, beginningDate: _beginningDate!,
                        endDate: _beginningDate!.add(Duration(days: subValue!.subscriptionDuration)), billId: billId!, billValue: subValue!.subscriptionValue, duration: subValue!.subscriptionDuration,
                        billCollector: collectorId, freezeAvailable: subValue!.subscriptionFreezeLimit, invitationAvailable: subValue!.subscriptionInvitationLimit);
                  await loadingDialog(context, -1, PlayersDatabaseManager().reSubscribePlayer(data), null).then((value) async{
                    Navigator.pop(context);
                    await displayInfoBar(context, builder: (context,closr)=>const InfoBar(title: Text("successfully re-subscribed")));
                  }) ;
                  }

                });
              }
            )
          ],
        ),),
      ),
    ));
  }
}


