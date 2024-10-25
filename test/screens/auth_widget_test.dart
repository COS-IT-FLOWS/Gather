import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/screens/auth_widget.dart'; // Adjust the import as necessary

// Mock class for SignInProvider
class MockSignInProvider extends Mock implements SignInProvider {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  group('AuthenticationWidget Tests', () {
    late MockSignInProvider mockSignInProvider;
    late MockGoogleSignIn mockGoogleSignIn;

    setUp(() async {
      mockSignInProvider = MockSignInProvider();
      mockGoogleSignIn = MockGoogleSignIn();
    });

    testWidgets('renders AuthenticationWidget correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<SignInProvider>.value(
          value: mockSignInProvider,
          child: MaterialApp(
            home: AuthenticationWidget(),
          ),
        ),
      );

      // Check if the Sign Up text is displayed
      expect(find.text('Sign Up'), findsOneWidget);
      // Check if the Google sign-in button is displayed
      expect(find.text('Continue with Google'), findsOneWidget);
      // Check if the phone number input field is displayed
      expect(find.byType(InternationalPhoneNumberInput), findsOneWidget);
    });

    // testWidgets('signs in with phone number', (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //     ChangeNotifierProvider<SignInProvider>.value(
    //       value: mockSignInProvider,
    //       child: MaterialApp(
    //         home: AuthenticationWidget(),
    //       ),
    //     ),
    //   );

    //   // Enter a phone number
    //   final phoneInputFinder = find.byType(InternationalPhoneNumberInput);
    //   await tester.enterText(phoneInputFinder, '+1234567890');

    //   // Tap the Sign Up with Phone button
    //   final signUpButtonFinder = find.text('Sign Up with Phone');
    //   await tester.tap(signUpButtonFinder);
    //   await tester.pumpAndSettle();

    //   // Verify that the signInWithPhoneNumber method was called
    //   verify(mockSignInProvider.signInWithPhoneNumber('+1234567890')).called(1);
    // });

    testWidgets('signs in with Google', (WidgetTester tester) async {
      when(mockSignInProvider.signInWithGoogle())
          .thenAnswer((_) async => 'user_id_123');
      await tester.pumpWidget(
        ChangeNotifierProvider<SignInProvider>(
            create: (_) => mockSignInProvider,
            builder: (context, child) {
              return MaterialApp(
                home: AuthenticationWidget(),
              );
            }),
      );

      // Tap the Google sign-in button
      final googleSignInButtonFinder = find.text('Continue with Google');
      await tester.tap(googleSignInButtonFinder);
      await tester.pumpAndSettle();
      // final output = await mockSignInProvider.signInWithGoogle();
      // print(output);
      // Verify that the signInWithGoogle method was called
      verify(mockSignInProvider.signInWithGoogle());
    });
  });
}
