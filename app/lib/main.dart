import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:gym_management/database_management/player_database_manager.dart';
import 'package:gym_management/main_screen/screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PlayersDatabaseManager().getDataFromBackup();
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
          home: const MainScreen(),
      ));
  }
}


