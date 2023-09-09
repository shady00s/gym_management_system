
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import 'package:gym_management/main_screen/widgets/take_new_image_widget.dart';




Future showInvitationWidget(context,int playerIndexId)async{
  await showGeneralDialog(context: context, pageBuilder: (context,animation,animation2)=> InvitationWidget(playerIndexId: playerIndexId,));
}

GlobalKey<FormState> key = GlobalKey<FormState>();
File? image;
String gender = "Male";

class InvitationWidget extends StatelessWidget {
  final int playerIndexId;
  const InvitationWidget({super.key,required this.playerIndexId});

  @override
  Widget build(BuildContext context) {
    return

      Center(child: SizedBox(
        width: 420,
        height: MediaQuery.sizeOf(context).width * 0.9,
        child: Card(backgroundColor:Colors.black ,child: Column(children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Invitation"),
          IconButton(icon: const Icon(FluentIcons.cancel), onPressed: (){
            Navigator.pop(context);
          })
          ],),
          // gym player invitation id
           const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Player available invitations:"),
                Text('1')
              ],
            ),

          // guest information

          const Text("Guest information"),
          StatefulBuilder(builder: (context,setState)=>Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // select player image
                  const Padding(padding: EdgeInsets.all(8),child: Text("Player image",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),
                 const TakeNewImageWidget(path: 'players_images'),
                  const  Divider(),
                  const SizedBox(height: 12,),
                  // player name
                  const Padding(padding: EdgeInsets.all(8),child: Text("Player name",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),
                  Row(children: [
                    Expanded(child: TextFormBox( placeholder: "first name",)),
                    const SizedBox(width: 10,),
                    Expanded(child:TextFormBox( placeholder: "second name",) ),
                    const SizedBox(width: 10,),
                    Expanded(child:TextFormBox( placeholder: "third name",)),
                  ],),
                  const   Divider(),
                  const    SizedBox(height: 12,),
                  //phone number
                  const Padding(padding: EdgeInsets.all(8),child: Text("Phone number",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormBox( placeholder: "first name",),
                  ),
                  const    Divider(),
                  const  SizedBox(height: 12,),
                  // player gender
                  const   Padding(padding: EdgeInsets.all(8),child: Text("Player gender",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ComboBox(
                        value: gender,
                        onChanged: (data){
                          setState(() {
                            gender = data!;
                          });
                        },
                        items: const [ComboBoxItem(value:"Male", child: Text("Male")),
                          ComboBoxItem(value:"Female",child: Text("Female"))]),
                  ),
                  const  Divider(),
                  const SizedBox(height: 12,),


                  const   Divider(),
                  const  SizedBox(height: 21,),
                  Center(
                    child: FilledButton(child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Add player"),
                    ), onPressed: (){}),
                  )

                ],
              ),
            ),
          ))
          ,

          ],),),
      ),);

  }
}
