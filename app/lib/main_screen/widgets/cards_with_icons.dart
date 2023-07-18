import 'package:flutter/material.dart';

class CardsWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  const CardsWithIcon({super.key,required this.title,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: (){},
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
    );
  }
}
