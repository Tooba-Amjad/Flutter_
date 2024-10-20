import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bottleee_spin/main.dart';

void main() {
  testWidgets('Spin the Bottle app test', (WidgetTester tester) async {
    await tester.pumpWidget( SpinTheBottleApp());

    // Verify that the title is displayed
    expect(find.text('Spin the Bottle Game'), findsOneWidget);

    // Further widget tests can be added here
  });
}
