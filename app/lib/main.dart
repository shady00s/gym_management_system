import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/view/screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1230, 760),
    center: true,
    minimumSize:Size(1000,760) ,
    maximumSize:Size(1230,760) ,
    backgroundColor: Colors.transparent,
    windowButtonVisibility: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
        title: "Gym management system",
        themeMode: ThemeMode.dark,
        color: Colors.blue,
        theme: FluentThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const Card(backgroundColor: Colors.black, child: MainScreen()));
  }
}
