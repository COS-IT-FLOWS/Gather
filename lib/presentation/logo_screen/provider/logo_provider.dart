import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/presentation/logo_screen/models/logo_model.dart';

/// A provider class for the LogoScreen.
///
/// This provider manages the state of the LogoScreen, including the
/// current logoModelObj
class LogoProvider extends ChangeNotifier {
  LogoModel logoModelObj = LogoModel();

  @override
  void dispose() {
    super.dispose();
  }
}
