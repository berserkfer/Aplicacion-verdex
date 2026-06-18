import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../providers/auth_provider.dart';
import '../citizen/citizen_shell.dart';
import '../collector/collector_shell.dart';
import '../operator/operator_shell.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!auth.isLoggedIn) {
      return const LoginScreen();
    }

    switch (auth.user!.role) {
      case UserRole.citizen:
        return const CitizenShell();
      case UserRole.collector:
        return const CollectorShell();
      case UserRole.operator:
        return const OperatorShell();
      case UserRole.unknown:
        return const LoginScreen();
    }
  }
}
