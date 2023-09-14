
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/add_new_player.dart';

import 'package:gym_management/main_screen/widgets/take_new_image_widget.dart';

import '../../database_management/tables/generate_table.dart';




Future showInvitationWidget(context,int playerIndexId)async{
  await showGeneralDialog(context: context, pageBuilder: (context,animation,animation2)=> InvitationWidget(playerIndexId: playerIndexId,));
}

GlobalKey<FormState> key = GlobalKey<FormState>();
TextEditingController firstName = TextEditingController();
TextEditingController middleName = TextEditingController();
TextEditingController lastName = TextEditingController();
TextEditingController phoneNumber = TextEditingController();
File? image;
String gender = "Male";
bool isNoImage = false;
class InvitationWidget extends StatelessWidget {
  final int playerIndexId;

  const InvitationWidget({super.key,required this.playerIndexId});

  @override
  Widget build(BuildContext context) {
    return

      Center(child: SizedBox(
        width: 420,
        height: MediaQuery.sizeOf(context).width * 0.9,
        child: Card(backgroundColor:Colors.black ,child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Invitation",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.yellow),),
                  IconButton(icon: const Icon(FluentIcons.cancel), onPressed: (){
                    Navigator.pop(context);
                  })
                ],),
            ),
            FutureBuilder<GetRemainingInvitationResult>(
              future: PlayersDatabaseManager().getInvitations(playerIndexId),
              builder: (context, snapshot) {

                switch (snapshot.connectionState){

                  case ConnectionState.waiting:
                    return Expanded(child: const Center(child: ProgressRing(),));
                  case ConnectionState.done:
                    if(snapshot.data != null ){
                      if(snapshot.data!.invitationAvailable == 0){
                        return Expanded(child: Center(child:  Card(backgroundColor: Colors.red,child: Text("This player has no invitations left"))));
                      }
                        return Expanded(
                          child: Column(children: [
                            // gym player invitation id
                            Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Card(
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Player available invitations:"),


                                    Text(snapshot.data!.invitationAvailable.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize:18),)




                                  ],
                                ),
                              ),
                            ),

                            // guest information
                            const SizedBox(height: 20,),
                            const Text("Guest information",style:TextStyle(fontWeight: FontWeight.w600,fontSize: 19),),
                            StatefulBuilder(builder: (context,setState)=>Form(
                              key: key,
                              child: SizedBox(
                                height: 500,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // select player image
                                      const Padding(padding: EdgeInsets.all(8),child: Text("Player image",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),)),
                                       TakeNewImageWidget(path: 'players_images', state: playerImageProvider,),
                                      if(isNoImage)
                                        Padding(
                                          padding:const  EdgeInsets.all(8.0),
                                          child: Text('please add bill image',style: TextStyle(color: Colors.red.lighter,fontWeight: FontWeight.w500),),
                                        ),
                                      const  Divider(),
                                      const SizedBox(height: 12,),
                                      // player name
                                      const Padding(padding: EdgeInsets.all(8),child: Text("Player name",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),
                                      Row(children: [
                                        Expanded(child: TextFormBox( placeholder: "first name",controller: firstName,validator: (val){
                                          if(val == ""){
                                            return "please add first name";
                                          }else{
                                            return null;
                                          }
                                        },)),
                                        const SizedBox(width: 10,),
                                        Expanded(child:TextFormBox( placeholder: "middle name",controller: middleName,validator: (val){
                                          if(val == ""){
                                            return "please add middle name";
                                          }else{
                                            return null;
                                          }
                                        },) ),
                                        const SizedBox(width: 10,),
                                        Expanded(child:TextFormBox( placeholder: "last name",controller: lastName,validator: (val){
                                          if(val == ""){
                                            return "please add last name";
                                          }else{
                                            return null;
                                          }
                                        },)),
                                      ],),
                                      const    SizedBox(height: 12,),
                                      //phone number
                                      const Padding(padding: EdgeInsets.all(8),child: Text("Phone number",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: NumberFormBox( placeholder: "phone number",validator: (val){
                                          if(val == null || val.length < 12){
                                            return "please add phone number";
                                          }else{
                                            return null;
                                          }
                                        },),
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


                                      const  SizedBox(height: 21,),
                                      Center(
                                        child: Consumer(

                                            builder: (context, ref,child) {
                                              var imagePath = ref.watch(playerImageProvider);
                                              return FilledButton(child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Submit invitation"),
                                              ), onPressed: (){
                                                if(imagePath == null){
                                                  setState(() {
                                                    isNoImage = true;
                                                  });
                                                }
                                                if(key.currentState!.validate() && image !=null){
                                                  setState(() {
                                                    isNoImage = false;
                                                  });


                                                }
                                              });
                                            }
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ))
                            ,

                          ],),
                        );

                    }

                  return Center(child: Text("Error occured"),);
                  default:
                  return const Center(child: ProgressRing(),);
                }

              }
            ),
          ],
        ),),
      ),);

  }
}
