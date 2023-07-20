import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:gym_management/main_screen/screen.dart';
import 'package:gym_management/manage_excel/ui_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Gym management',
        theme: ThemeData(
          brightness: Brightness.dark,

          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:FluentApp(
          theme: FluentThemeData.dark(),
          home: const ImportExcelScreen(),
      ));
  }
}


