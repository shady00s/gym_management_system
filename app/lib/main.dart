import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/database_management/tables/players/player_database_manager.dart';
import 'package:gym_management/main_screen/screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
       FluentApp(
         title:"Gym management system",
          themeMode: ThemeMode.dark,
          color: Colors.blue,
          theme: FluentThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home:
          const  Card( backgroundColor:Colors.black,child:  MainScreen())

      );
  }
}


