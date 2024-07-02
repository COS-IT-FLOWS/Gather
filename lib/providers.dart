// signin_provider.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gather/screens/otp_input_widget.dart';

class SignInProvider with ChangeNotifier {
  final SupabaseClient _supabaseClient;
  final OtpProvider _otpProvider;
  final BuildContext _context;

  SignInProvider(this._supabaseClient, this._otpProvider, this._context);

  Future<void> signInOtp(String phoneNumber) async {
    try {
      await _supabaseClient.auth.signInWithOtp(
        phone: phoneNumber,
      );

      // if (error != null) {
      //   print('Error: ${error.message}');
      //   return;
      // }

      // Show OTP input form to user
      await Navigator.pushNamed(_context, '/otpscreen');
      final otp = _otpProvider.otpValue;

      if (otp != null) {
        await _supabaseClient.auth
            .verifyOTP(phone: phoneNumber, token: otp, type: OtpType.signup);

        // if (error != null) {
        //   print('Error: ${error.message}');
        //   return;
        // }

        // User is signed in, update UI accordingly
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
    }
  }

//   Future _showOtpInputForm(BuildContext context) async {
//     // Implement OTP input form here
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => OtpInputWidget()));
//     // Return the OTP input by the user
//   }
}

class OtpProvider with ChangeNotifier {
  String _otpValue = '';
  String get otpValue => _otpValue;

  void updateOtpValue(String otp) {
    _otpValue = otp;
    notifyListeners();
  }
}
