import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:gather/routes/app_routes.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  PhoneNumber? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _model = AuthenticationModel();

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blueGrey,
        // appBar: AppBar(
        //   backgroundColor: Color(0xFFF1F4F8),
        //   automaticallyImplyLeading: false,
        //   actions: [],
        //   centerTitle: false,
        //   elevation: 0,
        // ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 150, 24, 150),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF15161E),
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InternationalPhoneNumberInput(
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: FFButtonWidget(
                        onPressed: _phoneNumberValid
                            ? () => Navigator.pushReplacementNamed(context, '/')
                            : null,
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
                    FFButtonWidget(
                      onPressed: () async {},
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
                          Text(
                            'Sign In',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
