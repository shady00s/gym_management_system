import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../camera_widget.dart';

class TakeNewImageWidget extends StatelessWidget {
  final String path;
  final StateProvider<String?> state;
  const TakeNewImageWidget({super.key,required this.path,required this.state});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer(

        builder: (context,ref,child) {
          var image = ref.watch(state);
          return Row(
            children: [
              image == null?const CircleAvatar(
                radius: 25,
                backgroundColor: Color.fromRGBO(
                    176, 175, 175, 0.7019607843137254),
                child: Icon(FluentIcons.contact ,size: 31,),
              ) : SizedBox(
                  width: 200,
                  height: 100,
                  child: Image(image: FileImage(File(image)),fit: BoxFit.contain,)),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Button(child: const Text("take photo"), onPressed: () async{

                  await showDialog(context: context, builder: (context)=>
                      ContentDialog(
                        style: const ContentDialogThemeData(

                            decoration: BoxDecoration(color: Color.fromRGBO(
                                16, 15, 15, 1.0)) ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Camera"),
                            IconButton(icon: const Icon(FluentIcons.cancel), onPressed: (){Navigator.pop(context);})
                          ],), content:   TakeNewPhoto(path:path, state: state,),));

                }),
              ),
            ],
          );
        }
      ),
    );
  }
}

