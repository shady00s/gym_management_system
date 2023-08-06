import 'package:fluent_ui/fluent_ui.dart';

class AddNewSubscriptionValueWidget extends StatefulWidget {
  const AddNewSubscriptionValueWidget({super.key});

  @override
  State<AddNewSubscriptionValueWidget> createState() => _AddNewSubscriptionValueWidgetState();
}

class _AddNewSubscriptionValueWidgetState extends State<AddNewSubscriptionValueWidget> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key:_formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center
          ,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Add new subscription",style: TextStyle(fontSize: 31,fontWeight: FontWeight.w500),),
           const SizedBox(height: 31,),
            Text("Set subscription duration"),

            const SizedBox(height: 8,),
            SizedBox(width: 220, child: Row(
              children: [
                Expanded(child:NumberFormBox(value: 0, onChanged: (val){})),
                SizedBox(width: 20,),
                Text("Days")
              ],
            )),
            const SizedBox(height: 21,),
            Text("Set subscription value"),
            const SizedBox(height: 8,),
            SizedBox(width: 220, child: Row(
              children: [
                Expanded(child:NumberFormBox(value: 0, onChanged: (val){})),
                SizedBox(width: 20,),
                Text("LE")
              ],
            )),
            const SizedBox(height: 21,),
            Text("Set freeze limit"),
            const SizedBox(height: 8,),
            SizedBox(width: 220, child: Row(
              children: [
                Expanded(child:NumberFormBox(value: 0, onChanged: (val){})),
                SizedBox(width: 20,),
                Text("Days")
              ],
            )),
            const SizedBox(height: 21,),

            Text("Set number of invitations"),
            const SizedBox(height: 8,),
            SizedBox(width: 220, child: Row(
              children: [
                Expanded(child:NumberFormBox(value: 0, onChanged: (val){},validator: (val){
                  if(val == null){
                    return"Please add number invitations";
                  }

                  return null;
                },)),
                SizedBox(width: 20,),
                Text("Invitations")
              ],
            )),
            const SizedBox(height: 41,),

            Button(child:const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Text("Save subscription"),
            ), onPressed: (){
              if(_formKey.currentState!.validate()){

              }
              
            })
          ],
        ),
      ),
    );
  }
}
