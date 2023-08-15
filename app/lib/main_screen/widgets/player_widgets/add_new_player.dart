import 'package:fluent_ui/fluent_ui.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:gym_management/camera_widget.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPlayerWidget extends StatefulWidget {
  const AddNewPlayerWidget({super.key});

  @override
  State<AddNewPlayerWidget> createState() => _AddNewPlayerWidgetState();
}

class _AddNewPlayerWidgetState extends State<AddNewPlayerWidget> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
@override
  void initState() {
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  ContentDialog(
      title: Text("Add new player"),
      content: Padding(
        padding:const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // select player image
              const Padding(padding: EdgeInsets.all(8),child: Text("Player name",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 27),)),


                Button(child: Text("take photo"), onPressed: () async{

                await showDialog(context: context, builder: (context)=>ContentDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Camera"),
                      IconButton(icon: Icon(FluentIcons.cancel), onPressed: (){Navigator.pop(context);})
                ],), content:  const TakeNewPhoto(),));

                }),
              // player name
              Padding(padding: EdgeInsets.all(8),child: Text("Player name",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 27),)),
              Row(children: [
                Expanded(child: TextFormBox( placeholder: "first name",)),
               const SizedBox(width: 10,),
                Expanded(child:TextFormBox( placeholder: "second name",) ),
               const SizedBox(width: 10,),
                Expanded(child:TextFormBox( placeholder: "third name",)),
              ],),
              SizedBox(height: 12,),
              //phone number
              Padding(padding: EdgeInsets.all(8),child: Text("Phone number",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 27),)),
              TextFormBox( placeholder: "first name",),
              SizedBox(height: 12,),
              // player gender
              Padding(padding: EdgeInsets.all(8),child: Text("Player gender",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 27),)),
              ComboBox(
                  onChanged: (data){},
                  items: [ComboBoxItem(child: Text("Male")),ComboBoxItem(child: Text("Female"))]),
              // player subscription
              Padding(padding: EdgeInsets.all(8),child: Text("Player subscription",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 27),)),
              ComboBox(
                  onChanged: (data){},
                  items: [ComboBoxItem(child: Text("Male")),ComboBoxItem(child: Text("Female"))]),
            ],
          ),
        ),
      ),
    );
  }
}
