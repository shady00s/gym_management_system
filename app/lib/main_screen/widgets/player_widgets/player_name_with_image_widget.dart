import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_card_information.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_name_widget.dart';

class PlayerNameWithImage extends StatelessWidget {
  final  String playerName;
  final String imagePath;
  final int playerId;
  final int playerIndexId;

   PlayerNameWithImage({super.key,required this.playerName,required this.playerId, required this.imagePath,required this.playerIndexId});
  final menuController = FlyoutController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button(
          onPressed:()async{
            await showDialog(context: context, builder: (_)=> ContentDialog(

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
              child:  Row(
                children: [
                  OptionsMenu( menuController),
                  const Spacer(),
                  Text(playerName??"No name"),
                  Text(" - $playerId "??"no id"),
                    SizedBox(width: 9,),
                    imagePath !="no-image"?Image(image: NetworkImage(imagePath),):CircleAvatar(
                      radius: 17,
                      backgroundColor: Color.fromRGBO(
                          176, 175, 175, 0.7019607843137254),
                      child: Icon(FluentIcons.contact ,size: 14,),
                    ),
                ],
              )

          ),),
        ));
  }
}
