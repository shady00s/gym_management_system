import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import '../../camera_widget.dart';

class TakeNewImageWidget extends StatefulWidget {
  final File? image;
  const TakeNewImageWidget({super.key,required this.image});

  @override
  State<TakeNewImageWidget> createState() => _TakeNewImageWidgetState();
}

class _TakeNewImageWidgetState extends State<TakeNewImageWidget> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          widget.image == null?const CircleAvatar(
            radius: 25,
            backgroundColor: Color.fromRGBO(
                176, 175, 175, 0.7019607843137254),
            child: Icon(FluentIcons.contact ,size: 31,),
          ) : Image(image: FileImage(widget.image!),),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Button(child: Text("take photo"), onPressed: () async{

              await showDialog(context: context, builder: (context)=>
                  ContentDialog(
                    style: const ContentDialogThemeData(

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
    );
  }
}
