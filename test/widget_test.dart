import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sync/main.dart';

void main() {
  testWidgets('Splash screen renders app name', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('LegalSync'), findsOneWidget);

    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
  });
}
