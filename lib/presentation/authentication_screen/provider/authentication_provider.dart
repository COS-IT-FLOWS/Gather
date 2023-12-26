import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/presentation/authentication_screen/models/authentication_model.dart';

/// A provider class for the AuthenticationScreen.
///
/// This provider manages the state of the AuthenticationScreen, including the
/// current authenticationModelObj
class AuthenticationProvider extends ChangeNotifier {
  TextEditingController phoneNumberController = TextEditingController();

  AuthenticationModel authenticationModelObj = AuthenticationModel();

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
  }
}
