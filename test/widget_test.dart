import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:verdex/app/verdex_app.dart';
import 'package:verdex/providers/auth_provider.dart';
import 'package:verdex/services/api_service.dart';
import 'package:verdex/services/auth_service.dart';

void main() {
  testWidgets('Shows login screen', (WidgetTester tester) async {
    final api = ApiService();
    final auth = AuthService(api);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(auth, api),
          ),
        ],
        child: const VerdexApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Verdex App'), findsOneWidget);
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}
