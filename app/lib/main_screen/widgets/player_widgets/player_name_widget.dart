import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_card_information.dart';

import '../invitation_widget.dart';
import '../re-subscription/re_subscription_widget.dart';
class PlayerNameWidget extends StatelessWidget {
  final  String playerName;
  final int playerId;
  final int playerIndexId;

    PlayerNameWidget(this.playerName,this.playerId,this.playerIndexId,{super.key});
  final menuController = FlyoutController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Button(
        onPressed:()async{
          await showGeneralDialog(context: context, pageBuilder:(context,animation,animations)=>

          Card(backgroundColor: const Color.fromRGBO(12, 2, 3, 0.3),child: Center(
          child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.90,
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: Card(
          backgroundColor: Colors.black,
          child: Column(children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Player Information",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              },
                icon:const Icon(FluentIcons.cancel),
              )
            ],
          ),
            Expanded(child: PlayerCardInformationWidget(playerId: playerIndexId,)),




              Row(children: [
                 Button(child:const Text("Re-new") ,onPressed: ()async{
                  await showReSubscriptionWidget(context,playerIndexId);},),
                  Button(child:const Text("Invitation") ,onPressed: (){},),
                  Button(child:const Text("Freeze") ,onPressed: (){},),
            ],)

          ],))))));


        },child:  Padding(
          padding:const EdgeInsets.all(8.0),


          child: FlyoutTarget(controller: menuController,
            child:  Row(
            children: [
              OptionsMenu( menuController,playerIndexId),
              const Spacer(),
              Text(playerName),
              Text(" - $playerId ")

    ],
    )

        ),),
    ));
  }
}

class OptionsMenu extends StatelessWidget {

  final FlyoutController menuController;
  final int playerIndexId;
  const OptionsMenu(this.menuController,this.playerIndexId, {super.key});

  @override
  Widget build(BuildContext context) {
    return  IconButton(icon: const Icon(FluentIcons.more_vertical),onPressed: (){
      menuController.showFlyout(
          autoModeConfiguration: FlyoutAutoConfiguration(
            preferredMode: FlyoutPlacementMode.left,
          ),
          barrierDismissible: true,
          dismissOnPointerMoveAway: false,
          dismissWithEsc: true,

          builder: (context){
            return   MenuFlyout(items: [
              MenuFlyoutItem(
                leading: const Icon(FluentIcons.refresh),
                text: const Text('Re-subscribe'),
                onPressed: () async{
                  Navigator.pop(context);
                  await showReSubscriptionWidget(context,playerIndexId);},
              ),
              MenuFlyoutItem(
                leading: const Icon(FluentIcons.stop),
                text: const Text('Freeze'),
                onPressed: ()async{
                  Navigator.pop(context);
                  await showInvitationWidget(context,playerIndexId);
                },
              ),
              MenuFlyoutItem(
                leading: const Icon(FluentIcons.contact_heart),
                text: const Text('Invitation'),
                onPressed: ()async{
                  Navigator.pop(context);
                  await showInvitationWidget(context,playerIndexId);
                },
              )]);
          });
    },);
  }
}

