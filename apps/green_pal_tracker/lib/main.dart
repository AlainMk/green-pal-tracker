import 'package:flutter/material.dart';
import 'package:green_pal_tracker/main/main_screen.dart';
import 'package:green_pal_tracker/shared/di.dart';
import 'package:green_pal_ui/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjector.inject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenPal App Tracker',
      theme: GreenPalTheme.light(),
      home: const MainScreen(),
    );
  }
}
