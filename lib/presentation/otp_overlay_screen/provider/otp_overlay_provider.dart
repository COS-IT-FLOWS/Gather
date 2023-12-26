import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/presentation/otp_overlay_screen/models/otp_overlay_model.dart';

/// A provider class for the OtpOverlayScreen.
///
/// This provider manages the state of the OtpOverlayScreen, including the
/// current otpOverlayModelObj

// ignore_for_file: must_be_immutable
class OtpOverlayProvider extends ChangeNotifier {
  OtpOverlayModel otpOverlayModelObj = OtpOverlayModel();

  @override
  void dispose() {
    super.dispose();
  }
}
