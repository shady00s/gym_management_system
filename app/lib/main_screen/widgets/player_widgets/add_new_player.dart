import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:gym_management/camera_widget.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_status/filter_element.dart';
import 'package:gym_management/main_screen/widgets/player_widgets/player_status/filter_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../../database_management/tables/subscriptions/subscriptions_information_manager.dart';

class AddNewPlayerWidget extends StatefulWidget {
  const AddNewPlayerWidget({super.key});

  @override
  State<AddNewPlayerWidget> createState() => _AddNewPlayerWidgetState();
}

class _AddNewPlayerWidgetState extends State<AddNewPlayerWidget> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  File? image;
  String gender = "Male";
@override
  void initState() {
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  ContentDialog(
      style: ContentDialogThemeData(

          decoration: BoxDecoration(color: Color.fromRGBO(
              16, 15, 15, 1.0)) ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text("Add new player"),
          IconButton(icon: Icon(FluentIcons.cancel), onPressed: (){
            Navigator.pop(context);
          })
        ],
      ),
      content:Card(

        child: Padding(
        padding:const EdgeInsets.all(8.0),
        child:  Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // select player image
                  const Padding(padding: EdgeInsets.all(8),child: Text("Player image",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                         image == null?const CircleAvatar(
                              radius: 25,
                              backgroundColor: Color.fromRGBO(
                                  176, 175, 175, 0.7019607843137254),
                              child: Icon(FluentIcons.contact ,size: 31,),
                            ) : Image(image: FileImage(image!),),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(child: Text("take photo"), onPressed: () async{

                            await showDialog(context: context, builder: (context)=>
                                ContentDialog(
                                  style: ContentDialogThemeData(

                                      decoration: BoxDecoration(color: Color.fromRGBO(
                                          16, 15, 15, 1.0)) ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text("Camera"),
                                  IconButton(icon: Icon(FluentIcons.cancel), onPressed: (){Navigator.pop(context);})
                            ],), content:  const TakeNewPhoto(),));

                            }),
                          ),
                        ],
                      ),
                    ),
                const  Divider(),
                  const SizedBox(height: 12,),
                  // player name
                  Padding(padding: EdgeInsets.all(8),child: Text("Player name",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),
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
                  Padding(padding: EdgeInsets.all(8),child: Text("Phone number",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),
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
                        items: [ComboBoxItem(value:"Male", child: Text("Male")),
                          ComboBoxItem(value:"Female",child: Text("Female"))]),
                  ),
                  const  Divider(),
                  const SizedBox(height: 12,),

                  // player subscription
                  Padding(padding: EdgeInsets.all(8),child: Text("Player subscription",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),)),

                  FilterElement(
                      future:SubscriptionInformationManager().getAllSubscriptions(),
                      title: 'Subscription value',
                      list: null, allButton: true,
                      isSubscription: true,
                      isSubscriptionWithName:true,
                      onChange: (val) {}

                 ,provider: emptyProvider),

                  const   Divider(),
                  const  SizedBox(height: 21,),
                  Center(
                    child: FilledButton(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Add player"),
                    ), onPressed: (){}),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
