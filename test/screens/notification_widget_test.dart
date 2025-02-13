import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/appbar_widget.dart';
import 'package:gather/components/floating_camera_widget.dart';
import 'package:gather/screens/notification_widget.dart'; // Adjust the import based on your file structure

void main() {
  testWidgets('NotificationWidget has correct structure',
      (WidgetTester tester) async {
    // Build the NotificationWidget
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationWidget(),
      ),
    );

    // Verify the app bar title
    expect(find.text('Notifications'), findsOneWidget);

    // Verify the notification message
    expect(find.text('You have 0 notifications'), findsOneWidget);

    // Verify the presence of the floating action button
    expect(find.byType(FloatingCameraWidget), findsOneWidget);
  });
}
