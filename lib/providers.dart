import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class SignInProvider with ChangeNotifier {
  final SupabaseClient _supabaseClient;
  bool _isLoggedIn = false;
  late String _phoneNumber;
  String _otpValue = '';
  String get otpValue => _otpValue;

  bool get isLoggedIn => _isLoggedIn;

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

  // bool get isLoggedIn => _isLoggedIn;

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    _phoneNumber = phoneNumber;
    await _supabaseClient.auth
        .signInWithOtp(phone: phoneNumber, channel: OtpChannel.sms);
    notifyListeners();
  }

  Future<void> verifyOtp(String otp) async {
    print(_phoneNumber + otp);
    try {
      await _supabaseClient.auth.verifyOTP(
        phone: _phoneNumber,
        token: otp,
        type: OtpType.sms,
      );
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
    notifyListeners();
  }

  void updateOtpValue(String otp) {
    _otpValue = otp;
    notifyListeners();
  }
}
