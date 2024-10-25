import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/screens/otp_input_widget.dart'; // Replace with the actual file path
import '../mock_classes.dart'; // Import the mock classes

void main() {
  testWidgets('OtpInputWidget test with Mockito', (WidgetTester tester) async {
    // Create a mock SignInProvider
    final mockSignInProvider = MockAuthProvider();
    // when(mockSignInProvider.signInWithPhoneNumber('1234567890')).thenAnswer((_) => );

    // Build the OtpInputWidget within a Provider
    await tester.pumpWidget(ChangeNotifierProvider<SignInProvider>(
        create: (_) => mockSignInProvider,
        builder: (context, child) {
          return MaterialApp(home: OtpInputWidget());
        }));

    // Verify that six input fields are rendered
    expect(find.byType(TextFormField), findsNWidgets(6));

    // Enter OTP values
    for (int i = 0; i < 6; i++) {
      await tester.enterText(find.byType(TextFormField).at(i), '1');
      await tester.pump(); // Rebuild the widget
    }

    // Verify that the verifyOtp method is called when the full OTP is entered
    // when(mockSignInProvider.verifyOtp('123456')).thenAnswer((_) async {
    //   // Simulate a successful OTP verification
    //   when(mockSignInProvider.isLoggedIn).thenReturn(true);
    // });

    // Enter the correct OTP
    await tester.enterText(find.byType(TextFormField).at(0), '1');
    await tester.enterText(find.byType(TextFormField).at(1), '2');
    await tester.enterText(find.byType(TextFormField).at(2), '3');
    await tester.enterText(find.byType(TextFormField).at(3), '4');
    await tester.enterText(find.byType(TextFormField).at(4), '5');
    await tester.enterText(find.byType(TextFormField).at(5), '6');
    await tester.pump(); // Rebuild the widget

    // Verify that the verifyOtp method was called with the correct OTP
    // verify(mockSignInProvider.verifyOtp('123456')).called(1);

    // Verify that the user is logged in
    expect(mockSignInProvider.isLoggedIn, isTrue);

    // Verify that navigation occurs (you can check for the route if needed)
    // This part may require additional setup to verify navigation
    // For example, you can use a mock navigator or check the route
  });
}
