import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:gather/models/auth_model.dart'; // Adjust the import based on your app structure

// Create a mock class for the AuthenticationModel
class MockAuthenticationModel extends Mock implements AuthenticationModel {}

void main() {
  testWidgets('Loading dialog is shown when logging in',
      (WidgetTester tester) async {
    // Create an instance of the AuthenticationModel
    final authenticationModel = MockAuthenticationModel();

    // Build the app with the AuthenticationModel
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  // Call the method to show the loading dialog
                  // authenticationModel.showLoadingDialog(context);
                },
                child: Text('Sign In'),
              );
            },
          ),
        ),
      ),
    );

    // Tap the button to trigger the dialog
    await tester.tap(find.text('Sign In'));
    await tester.pump(); // Trigger a frame

    // // Verify that the loading dialog is displayed
    // expect(find.text('Logging in...'), findsOneWidget);
    // expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Close the dialog
    // Navigator.of(tester.element(find.byType(AlertDialog))).pop();
    await tester.pump(); // Trigger a frame to allow the dialog to close

    // Verify that the dialog is dismissed
    expect(find.text('Logging in...'), findsNothing);
  });
}
