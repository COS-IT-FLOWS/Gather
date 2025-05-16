import 'dart:io';

// import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

import 'package:gather/themes/app_theme.dart';

// import 'package:supabase_auth_ui/supabase_auth_ui.dart';
// import 'package:gather/services/supabase_service.dart';
// import 'package:intl/intl.dart';
// import 'package:phone_number/phone_number.dart' as phone_ver;

import '../models/auth_model.dart';
export '../models/auth_model.dart';

class AuthenticationWidget extends StatefulWidget {
  const AuthenticationWidget({super.key});

  @override
  State<AuthenticationWidget> createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  late AuthenticationModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = TextEditingController();
  bool _phoneNumberValid = false;
  late PhoneNumber _phoneNumber;
  SignInProvider? _signInProvider;
  // bool _providersInitialized = false;

  @override
  void initState() {
    super.initState();
    _model = AuthenticationModel();
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    // late PhoneNumber _phoneNumber;
    // late SignInProvider _signInProvider;
    // _otpProvider = Provider.of<OtpProvider>(context, listen: false);
    _signInProvider = Provider.of<SignInProvider>(context, listen: false);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!_providersInitialized) {
  //     _otpProvider = Provider.of<OtpProvider>(context, listen: false);
  //     _signInProvider = Provider.of<SignInProvider>(context, listen: false);
  //     _providersInitialized = true;
  //   }
  // }

  void _signInWithPhone() async {
    if (_signInProvider == null) return;
    FocusScope.of(context).requestFocus(FocusNode());
    late var _phoneNumberStr = _phoneNumber.phoneNumber.toString();
    await _signInProvider!.signInWithPhoneNumber(_phoneNumberStr);
    if (!mounted) return;
    Navigator.pushNamed(context, '/otpscreen');
  }

  void _signInWithGoogleAuth() async {
    final String userId;
    if (_signInProvider == null) return;
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent the user from tapping outside to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: SizedBox(
            width: 101,
            height: 151,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 21),
                Text(
                    style: TextStyle(color: AppTheme.primaryColor(context)),
                    "Logging in..."),
              ],
            ),
          ),
        );
      },
    );
    try {
      userId = await _signInProvider!.signInWithGoogle();
      print('This is the USER ID: $userId');
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('This is the error: $e');
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Invalid Gmail ID"),
            actions: <Widget>[
              ElevatedButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ); // Close the dialog
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _otpProvider = Provider.of<OtpProvider>(context, listen: );
    _signInProvider = Provider.of<SignInProvider>(context, listen: true);
    return Consumer<SignInProvider>(builder: (context, signInProvider, child) {
      _signInProvider = signInProvider;
      return GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
            : FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.grey.shade300,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            top: true,
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 150, 24, 150),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF15161E),
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
                          _signInWithGoogleAuth();
                        }
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        size: 24,
                      ),
                      label: Text('Continue with Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        padding: EdgeInsets.zero,
                        elevation: 2,
                        textStyle: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF15161E),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: AppTheme.tertiaryColor(context),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF606A85),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          // Do something with the phone number
                          setState(() {
                            _phoneNumber = number;
                          });
                        },
                        onInputValidated: (bool value) {
                          // Do something when the phone number is validated
                          _phoneNumberValid = value;
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: PhoneNumber(isoCode: 'IN'),
                        textFieldController: _controller,
                        keyboardType: TextInputType.phone,
                        inputDecoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF15161E),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF15161E),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.primaryColor(context),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        ),
                        //  InputDecoration(
                        //   labelText: 'Phone Number',
                        //   border: OutlineInputBorder(),
                        // ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: ElevatedButton(
                        onPressed: () => _signInWithPhone(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor(context),
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                          padding: EdgeInsets.zero,
                          elevation: _phoneNumberValid ? 4 : 0,
                          textStyle: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('Sign Up with Phone'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
