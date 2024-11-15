import 'package:flutter/material.dart';
import 'package:green_pal_ui/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenPal App UI',
      theme: GreenPalTheme.light(),
      home: const Scaffold(),
    );
  }
}
