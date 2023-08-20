import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_card_information.dart';
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
          await showDialog(context: context, builder: (context)=> ContentDialog(
            style:const ContentDialogThemeData(
                decoration: BoxDecoration(color: Color.fromRGBO(
                    16, 15, 15, 1.0)) ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Text("Player Information"),
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                  icon:const Icon(FluentIcons.cancel),
                )
              ],
            ),
            content: Card(child: PlayerCardInformationWidget(playerId: playerIndexId,)),
            actions: [
              Button(child:const Text("Re-new") ,onPressed: (){},),
              Button(child:const Text("Invitation") ,onPressed: (){},),
              Button(child:const Text("Freeze") ,onPressed: (){},),
            ],
          ));
        },child:  Padding(
          padding:const EdgeInsets.all(8.0),


          child: FlyoutTarget(controller: menuController,
            child:  Row(
            children: [
              OptionsMenu( menuController),
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
  const OptionsMenu(this.menuController, {super.key});

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
                onPressed: Flyout.of(context).close,
              ),
              MenuFlyoutItem(
                leading: const Icon(FluentIcons.stop),
                text: const Text('Freeze'),
                onPressed: Flyout.of(context).close,
              ),
              MenuFlyoutItem(
                leading: const Icon(FluentIcons.contact_heart),
                text: const Text('Invitation'),
                onPressed: Flyout.of(context).close,
              )]);
          });
    },);
  }
}

