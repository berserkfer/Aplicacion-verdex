import 'package:flutter/material.dart';

import '../navigation/main_shell.dart';
import '../theme/app_theme.dart';

class VerdexApp extends StatelessWidget {
  const VerdexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VERDEX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}
