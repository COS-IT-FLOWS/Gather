import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Import your SignInProvider class
import 'package:gather/providers/auth_provider.dart'; // Update with the correct path

// Create a mock class for SupabaseClient
class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late MockSupabaseClient mockSupabaseClient;
  late SignInProvider signInProvider;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    signInProvider = SignInProvider(mockSupabaseClient);
  });

  group('SignInProvider', () {
    test('initial values are set correctly', () {
      expect(signInProvider.isLoggedIn, false);
      expect(signInProvider.userId, '');
      expect(signInProvider.otpValue, '');
    });

    test('signInWithPhoneNumber sets phone number and calls signInWithOtp',
        () async {
      const phoneNumber = '1234567890';

      when(mockSupabaseClient.auth.signInWithOtp(
        phone: phoneNumber,
        channel: OtpChannel.sms,
      )).thenAnswer((_) async => Future.value());

      await signInProvider.signInWithPhoneNumber(phoneNumber);

      expect(signInProvider.isLoggedIn, false);
      expect(signInProvider.userId, '');
    });

//     test('verifyOtp updates userId and isLoggedIn', () async {
//       const phoneNumber = '1234567890';
//       const otp = '123456';

//       signInProvider.updateOtpValue(otp);
//       when(mockSupabaseClient.auth.verifyOTP(
//         phone: phoneNumber,
//         token: otp,
//         type: OtpType.sms,
//       )).thenAnswer((_) async => AuthResponse(user: User(id: 'user-id', appMetadata: {})));

//       await signInProvider.signInWithPhoneNumber(phoneNumber);
//       await signInProvider.verifyOtp(otp);

//       expect(signInProvider.isLoggedIn, true);
//       expect(signInProvider.userId, 'user-id');
//     });

//     test('signOut updates isLoggedIn to false', () async {
//       signInProvider.signInWithPhoneNumber('1234567890');
//       signInProvider.verifyOtp('123456');

//       await signInProvider.signOut();

//       expect(signInProvider.isLoggedIn, false);
//       expect(signInProvider.userId, '');
//     });

//     test('updateOtpValue updates otpValue', () {
//       const otp = '123456';
//       signInProvider.updateOtpValue(otp);

//       expect(signInProvider.otpValue, otp);
//     });

//     test('signInWithGoogle updates userId and isLoggedIn', () async {
//       final mockGoogleSignIn = MockGoogleSignIn();
//       const idToken = 'mock-id-token';
//       const accessToken = 'mock-access-token';

//       final mockGoogleUser  = GoogleSignInAccount(
//         id: 'mock-id',
//         displayName: 'Mock User',
//         email: 'mockuser@example.com',
//         photoUrl: 'http://example.com/photo.jpg',
//       );

//       when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleUser );
//       when(mockGoogleSignIn.authentication).thenAnswer((_) async => GoogleSignInAuthentication(
//         accessToken: accessToken,
//         idToken: idToken,
//       ));

//       when(mockSupabaseClient.auth.signInWithIdToken(
//         provider: anyNamed('provider'),
//         idToken: idToken,
//         accessToken: accessToken,
//       )).thenAnswer((_) async => AuthResponse(user: User(id: 'user-id')));

//       await signInProvider.signInWithGoogle();

//       expect(signInProvider.isLogged in, true);
//       expect(signInProvider.userId, 'user-id');
//     });
  });
}
