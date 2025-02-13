import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gather/components/floating_camera_widget.dart'; // Adjust the import based on your file structure

void main() {
  testWidgets('displays the Report Hazard button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FloatingCameraWidget(),
        ),
      ),
    );

    // Verify that the button is displayed
    expect(find.text('Report Hazard'), findsOneWidget);
  });

  testWidgets('navigates to /eventreport when button is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/eventreport': (context) =>
              Scaffold(body: Text('Event Report Page')),
        },
        home: Scaffold(
          body: FloatingCameraWidget(),
        ),
      ),
    );

    // Tap the button
    await tester.tap(find.text('Report Hazard'));
    await tester.pumpAndSettle();

    // Verify that the navigation occurred
    expect(find.text('Event Report Page'), findsOneWidget);
  });

  // Mocking the ImagePicker for camera and gallery functionality can be complex.
  // You can use a package like `mockito` to create a mock for ImagePicker if needed.
}
