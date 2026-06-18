import 'package:flutter/material.dart';

import '../screens/auth/auth_gate.dart';
import '../theme/app_theme.dart';

class VerdexApp extends StatelessWidget {
  const VerdexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verdex App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AuthGate(),
    );
  }
}
