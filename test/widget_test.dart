import 'package:flutter_test/flutter_test.dart';

import 'package:vastrax/core/app.dart';

void main() {
  testWidgets('shows Vastrax collection home', (WidgetTester tester) async {
    await tester.pumpWidget(const VastraxApp());
    await tester.pumpAndSettle();

    expect(find.text('Vastrax'), findsOneWidget);
    expect(find.text('Prithvi & Dhaga'), findsOneWidget);
    expect(find.textContaining('Earth Weave'), findsWidgets);
  });
}
