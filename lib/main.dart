import 'package:flutter/material.dart';
import 'navigation/main_shell.dart';

void main() {
  runApp(const VerdexApp());
}

class VerdexApp extends StatelessWidget {
  const VerdexApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'VERDEX',

      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF5F7F4),
      ),

      home: const MainShell(),
    );
  }
}