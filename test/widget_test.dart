import 'package:flutter_test/flutter_test.dart';

import 'package:verdex/app/verdex_app.dart';

void main() {
  testWidgets('Home shows welcome message', (WidgetTester tester) async {
    await tester.pumpWidget(const VerdexApp());
    await tester.pumpAndSettle();

    expect(find.text('Bienvenido a VERDEX'), findsOneWidget);
    expect(
      find.text('Recicla y ayuda al medio ambiente en Chiclayo'),
      findsOneWidget,
    );
  });
}
