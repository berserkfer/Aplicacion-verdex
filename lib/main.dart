import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/verdex_app.dart';
import 'providers/auth_provider.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final api = ApiService();
  final auth = AuthService(api);
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>.value(value: api),
        Provider<AuthService>.value(value: auth),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(auth, api)..bootstrap(),
        ),
      ],
      child: const VerdexApp(),
    ),
  );
}
