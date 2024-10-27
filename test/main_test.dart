import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/routes/app_routes.dart';
import 'package:gather/main.dart'; // Replace with the actual file path
import 'mock_classes.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('GatherApp initializes with correct initial route',
      (WidgetTester tester) async {
    // Create a mock SignInProvider
    final mockSignInProvider = MockAuthProvider();

    // Set up the mock to return false for isLoggedIn initially
    // when(mockSignInProvider.isLoggedIn).thenReturn(false);

    // Build the GatherApp within a Provider
    await tester.pumpWidget(
      ChangeNotifierProvider<SignInProvider>.value(
        value: mockSignInProvider,
        child: MaterialApp(
          home: GatherApp(),
        ),
      ),
    );

    // Verify that the initial route is '/authentication' when not logged in
    expect(find.text('Sign Up'),
        findsOneWidget); // Adjust this to match your authentication screen widget

    // Change the mock to simulate a logged-in user
    // // when(mockSignInProvider.isLoggedIn).thenReturn(true);
    await tester.pumpAndSettle(); // Rebuild the widget

    // // Verify that the initial route changes to '/home' when logged in
    // expect(find.text('Home Screen'),
    //     findsOneWidget); // Adjust this to match your home screen widget
  });
}
