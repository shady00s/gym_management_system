
import 'package:fluent_ui/fluent_ui.dart' ;
import 'package:flutter/material.dart'as m;

class CardsWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  const CardsWithIcon({super.key,required this.title,required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
      child: Button(
        onPressed: (){
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            )
          ],
      ),
        ),
      ),
    );
  }
}
