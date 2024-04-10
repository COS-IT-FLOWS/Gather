import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/screens/notification_widget.dart';

void main() {
  testWidgets('NotificationWidget renders Text widget with correct text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NotificationWidget(),
    ));

    expect(find.text('You have 0 notifications'), findsOneWidget);
  });
}
