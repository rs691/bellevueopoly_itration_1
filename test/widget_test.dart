// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bellevueopoly_iteration_1/screens/home_screen.dart';

import 'package:bellevueopoly_iteration_1/main.dart';

void main() {
  testWidgets('App starts and shows the HomeScreen with a map', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BellevueopolyApp());

    // Verify that the root app widget is present.
    expect(find.byType(BellevueopolyApp), findsOneWidget);

    // Since routing is asynchronous, we might need to pump and settle.
    await tester.pumpAndSettle();

    // Verify that the HomeScreen is now visible.
    expect(find.byType(HomeScreen), findsOneWidget);
    // Verify that the GoogleMap widget within the HomeScreen is visible.
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
