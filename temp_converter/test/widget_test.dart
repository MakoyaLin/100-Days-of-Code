// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temp_converter/about.dart';
import 'package:temp_converter/converter.dart';

import 'package:temp_converter/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  testWidgets('Test switch', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final swWidget = find.byType(Switch);

    expect(tester.widget<Switch>(swWidget).value, true);

    await tester.tap(swWidget);
    await tester.pump();
    expect(tester.widget<Switch>(swWidget).value, false);
  });

  test('Converts Celsius', () {
    final converter = Converter();
    // Set an initial temperature
    converter.setTemp(50);
    // Expected result
    expect(converter.convertString(), '10.0°C');
  });

  test('Converts Fahrenheit', () {
    final converter = Converter();
    converter.toggle();
    converter.setTemp(50);
    expect(converter.convertString(), '122.0°F');
  });

  testWidgets('Test Widget Converts Celsius', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), '50');

    await tester.pump();

    expect(find.text("10.0°C"), findsWidgets);
  });

  testWidgets('Test Widget Converts Fahrenheit', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Find the switch widget.
    final switchWidget = find.byType(Switch);

    // Tap the switch to change the temperature unit to Fahrenheit.
    await tester.tap(switchWidget);
    await tester.pump();

    await tester.enterText(find.byType(TextField), '50');

    await tester.pump();

    expect(find.text("122.0°F"), findsWidgets);
  });

  testWidgets('is About Page', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: AboutPage(),
      ),
    ));
    final text = find.textContaining('This amazing app');
    expect(text, findsOneWidget);
  });

  testWidgets('Test Back Button ', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: AboutPage(),
      ),
    ));
    final btnWidget = find.byType(ElevatedButton);
    expect(btnWidget, findsOneWidget);
    await tester.tap(btnWidget);
    await tester.pump();
    
  });
}
