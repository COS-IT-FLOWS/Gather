import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/screens/auth_widget.dart'; // Adjust the import as necessary
import '../mock_classes.dart';

// Mock class for SignInProvider
// class MockSignInProvider extends Mock implements SignInProvider {}

void main() {
  group('AuthenticationWidget Tests', () {
    late MockAuthProvider mockAuthProvider;

    setUp(() async {
      mockAuthProvider = MockAuthProvider();
    });

    testWidgets('renders AuthenticationWidget correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<SignInProvider>.value(
          value: mockAuthProvider,
          child: MaterialApp(
            home: AuthenticationWidget(),
          ),
        ),
      );

      // Check if the Sign Up text is displayed
      expect(find.text('Sign Up'), findsOneWidget);
      // Check if the Google sign-in button is displayed
      expect(find.text('Continue with Google'), findsOneWidget);
      expect(find.text('Already have an account? '), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Sign Up with Phone'), findsOneWidget);
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

    testWidgets('Google Sign In failed', (WidgetTester tester) async {
      MockAuthFailedProvider mockAuthFailedProvider = MockAuthFailedProvider();
      await tester.pumpWidget(
        ChangeNotifierProvider<SignInProvider>(
            create: (_) => mockAuthFailedProvider,
            builder: (context, child) {
              return MaterialApp(
                home: AuthenticationWidget(),
              );
            }),
      );

      // Tap the Google sign-in button
      final googleSignInButtonFinder = find.text('Continue with Google');
      expect(googleSignInButtonFinder, findsOneWidget);
      await tester.tap(googleSignInButtonFinder);
      await tester.pump();
      // expect(find.byType(AlertDialog), findsNWidgets(1));
      // expect(find.text('Logging in...'), findsOneWidget);
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // await tester.pump;
      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Invalid Gmail ID'), findsOneWidget);
      final confirmationFinder = find.text('OK');
      expect(confirmationFinder, findsOneWidget);

      await tester.tap(confirmationFinder);
      await tester.pump();

      expect(find.text('Continue with Google'), findsOneWidget);

      expect(find.text('Sign Up'), findsOneWidget);

      // Verify that the signInWithGoogle method was called
      // verify(mockAuthProvider.signInWithGoogle()).called(1);
      // expect(find.text('Enter Data'), findsOneWidget);
    });

    testWidgets('Google Sign In Success', (WidgetTester tester) async {
      MockAuthProvider mockAuthSuccessProvider = MockAuthProvider();
      await tester.pumpWidget(
        ChangeNotifierProvider<SignInProvider>(
            create: (_) => mockAuthSuccessProvider,
            builder: (context, child) {
              return MaterialApp(initialRoute: '/', routes: {
                '/': (context) => AuthenticationWidget(),
                '/home': (context) => Center(child: Text('HomePage'))
              });
            }),
      );

      // Tap the Google sign-in button
      final googleSignInButtonFinder = find.text('Continue with Google');
      expect(googleSignInButtonFinder, findsOneWidget);
      await tester.tap(googleSignInButtonFinder);
      await tester.pumpAndSettle();
      // expect(find.byType(AlertDialog), findsOneWidget);
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // expect(find.text('Logging in...'), findsOneWidget);

      await tester.pump();
      // await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);

      expect(find.text('HomePage'), findsOneWidget);

      // Verify that the signInWithGoogle method was called
      // verify(mockAuthProvider.signInWithGoogle()).called(1);
      // expect(find.text('Enter Data'), findsOneWidget);
    });

    testWidgets('Phone Sign Up Route to OTP Screen',
        (WidgetTester tester) async {
      MockAuthProvider mockAuthSuccessProvider = MockAuthProvider();
      await tester.pumpWidget(
        ChangeNotifierProvider<SignInProvider>(
            create: (_) => mockAuthSuccessProvider,
            builder: (context, child) {
              return MaterialApp(initialRoute: '/', routes: {
                '/': (context) => AuthenticationWidget(),
                '/otpscreen': (context) => Center(child: Text('OTP Screen'))
              });
            }),
      );

      // Tap the Google sign-in button
      final signInButtonFinder = find.text('Sign Up with Phone');
      expect(signInButtonFinder, findsOneWidget);
      await tester.tap(signInButtonFinder);
      await tester.pumpAndSettle();
      // expect(find.byType(AlertDialog), findsOneWidget);
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // expect(find.text('Logging in...'), findsOneWidget);

      await tester.pumpAndSettle();
      // await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Sign Up'), findsOneWidget);

      // expect(find.text('OTP Screen'), findsOneWidget);

      // Verify that the signInWithGoogle method was called
      // verify(mockAuthProvider.signInWithGoogle()).called(1);
      // expect(find.text('Enter Data'), findsOneWidget);
    });
  });
}
