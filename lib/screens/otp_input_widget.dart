import 'package:flutter/material.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpInputWidget extends StatefulWidget {
  @override
  _OtpInputWidgetState createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  final _otpControllers =
      List<TextEditingController>.generate(6, (_) => TextEditingController());
  final _focusNodes = List<FocusNode>.generate(6, (_) => FocusNode());
  // SignInProvider? _signInProvider;

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _moveFocus(int index, bool forward) {
    if (forward && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (!forward && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _updateOtpValue() async {
    // if (_signInProvider == null) return;
    // print(_otpControllers);
    final otp = _otpControllers.map((controller) => controller.text).join();
    // print(otp.length);
    if (otp.length == 6) {
      await Provider.of<SignInProvider>(context, listen: false).verifyOtp(otp);
      if (Provider.of<SignInProvider>(context, listen: false).isLoggedIn ??
          false) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List<Widget>.generate(6, (index) {
            return SizedBox(
              width: 50,
              child: TextFormField(
                controller: _otpControllers[index],
                focusNode: _focusNodes[index],
                onChanged: (value) {
                  if (value.length == 1) {
                    _moveFocus(index, true);
                  } else if (value.isEmpty) {
                    _moveFocus(index, false);
                  }
                  print(value);
                  _updateOtpValue();
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
