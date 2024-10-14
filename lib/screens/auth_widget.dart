import 'dart:io';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

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
    // _signInProvider = Provider.of<SignInProvider>(context, listen: false);
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

  // void _signInWithGoogleAuth() async {
  //   if (_signInProvider == null) return;
  //   await _signInProvider!.signInWithGoogle();
  //   if (!mounted) return;
  //   Navigator.pushNamed(context, '/home');
  // }

  void _signInWithGoogleAuth() async {
    if (_signInProvider == null) return;
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent the user from tapping outside to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: SizedBox(
            width: 100,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                    style:
                        TextStyle(color: FlutterFlowTheme.of(context).primary),
                    "Logging in..."),
              ],
            ),
          ),
        );
      },
    );

    try {
      await _signInProvider!.signInWithGoogle();
      if (!mounted) return;
      Navigator.of(context).pop(); // Close the dialog
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      Navigator.of(context).pop(); // Close the dialog
      // Handle the error here, e.g., show an error message
      print("Error signing in: $e");
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
    // _signInProvider = Provider.of<SignInProvider>(context, listen: true);
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
                    FFButtonWidget(
                      onPressed: () async {
                        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
                          _signInWithGoogleAuth();
                        }
                      },
                      text: 'Continue with Google',
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        size: 24,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Colors.white,
                        textStyle: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
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
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF15161E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              _signInWithGoogleAuth();
                            },
                            child: Text(
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                'Sign In'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).labelLarge.override(
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
                              color: FlutterFlowTheme.of(context).primary,
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
                      child: FFButtonWidget(
                        // Commented out the check for valid phone number for ease of testing
                        // onPressed: _phoneNumberValid
                        // ? () => Navigator.pushReplacementNamed(context, '/')
                        // : null,
                        // onPressed: () =>
                        // Provider.of<SignInProvider>(context, listen: false)
                        // .signInOtp(_phoneNumber.phoneNumber.toString()),
                        onPressed: () => _signInWithPhone(),
                        text: 'Sign Up with Phone',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: _phoneNumberValid ? 4 : 0,
                          borderRadius: BorderRadius.circular(12),
                        ),
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
