import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_card_information.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_name_widget.dart';

class NeedToResubscribePlayerNameWidget extends StatelessWidget {
  final  String playerName;
  final int playerId;
  final int playerIndexId;
  final DateTime endDate;
   NeedToResubscribePlayerNameWidget({super.key,required this.playerName,required this.playerId,required this.endDate, required this.playerIndexId});
  final menuController = FlyoutController();
  @override
  Widget build(BuildContext context) {
    int date = DateTime.now().difference(endDate).inDays;

    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button(
          onPressed:()async{
            await showDialog(context: context, builder: (context)=> ContentDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Player Information"),
                  IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  },
                    icon: Icon(FluentIcons.cancel),
                  )
                ],
              ),
              content: PlayerCardInformationWidget(playerId: playerIndexId,),
              actions: [
                Button(child:Text("Re-new") ,onPressed: (){},),
                Button(child:Text("Invitation") ,onPressed: (){},),
                Button(child:Text("Freeze") ,onPressed: (){},),
              ],
            ));
          },child:  Padding(
          padding:const EdgeInsets.all(8.0),


          child: FlyoutTarget(controller: menuController,
              child:  Column(
                children: [
                  Row(
                    children: [
                      OptionsMenu( menuController),
                      const Spacer(),
                      Text(playerName??"No name"),
                      Text(" - $playerId "??"no id")

                    ],
                  ),
                Text("Subscription ended ${date ==0?  "today" : date==1?"yesterday": ' $date days ago'} ",style: TextStyle(color: Color.fromRGBO(
                    255, 166, 0, 0.7019607843137254)),)
                ],
              )

          ),),
        ));
  }
}
