import 'package:flutter/material.dart';
// import 'package:gather/providers.dart.backup';
import 'package:provider/provider.dart';

class OtpInputWidget extends StatefulWidget {
  @override
  _OtpInputWidgetState createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  final _otpController = TextEditingController();
  final _focusNodes = List<FocusNode>.generate(7, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _otpController.addListener(() {
      final text = _otpController.text;
      if (text.length == 6) {
        // Provider.of<OtpProvider>(context, listen: false).updateOtpValue(text);
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _moveFocus(int index) {
    if (index < 6 && _otpController.text.length > index) {
      _focusNodes[index].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(6, (index) {
        return SizedBox(
          width: 50,
          child: TextFormField(
            controller: _otpController,
            focusNode: _focusNodes[index],
            onChanged: (value) {
              if (value.length == 1) {
                _moveFocus(index + 1);
              }
              if (value.isEmpty && index > 0) {
                _moveFocus(index - 1);
              }
              // Provider.of<OtpProvider>(context, listen: false)
              // .updateOtpValue(value);
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
    );
  }
}
