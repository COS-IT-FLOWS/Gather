import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInProvider with ChangeNotifier {
  final SupabaseClient _supabaseClient;
  bool _isLoggedIn = false;
  late String _userId;
  late String _phoneNumber;
  String _otpValue = '';
  String get otpValue => _otpValue;

  bool get isLoggedIn => _isLoggedIn;
  String get userId => _userId;

  SignInProvider(this._supabaseClient) {
    final authSubscription =
        _supabaseClient.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        _isLoggedIn = true;
        notifyListeners();
      }
    });
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    _phoneNumber = phoneNumber;
    await _supabaseClient.auth
        .signInWithOtp(phone: phoneNumber, channel: OtpChannel.sms);
    notifyListeners();
  }

  Future<void> verifyOtp(String otp) async {
    print(_phoneNumber + otp);
    try {
      AuthResponse response = await _supabaseClient.auth.verifyOTP(
        phone: _phoneNumber,
        token: otp,
        type: OtpType.sms,
      );
      _isLoggedIn = true;
      _userId = response.user!.id;
      notifyListeners();
    } catch (e) {
      if (e is AuthException) {
        print('Auth error: ${e.message}');
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            GlobalConfiguration().get('SUPABASE_GOOGLE_AUTH_WEB_CLIENT_ID'));
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    if (accessToken == null) {
      throw Exception('No Access Token found');
    }
    if (idToken == null) {
      throw Exception('No ID Token found');
    }
    try {
      AuthResponse response = await _supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      _userId = response.user!.id;
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      if (e is AuthException) {
        print('Auth error: ${e.message}');
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
    _isLoggedIn = false;
    print(_isLoggedIn);
    notifyListeners();
  }

  void updateOtpValue(String otp) {
    _otpValue = otp;
    notifyListeners();
  }
}
