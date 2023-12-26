import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/presentation/analytics_screen/models/analytics_model.dart';

/// A provider class for the AnalyticsScreen.
///
/// This provider manages the state of the AnalyticsScreen, including the
/// current analyticsModelObj
class AnalyticsProvider extends ChangeNotifier {
  AnalyticsModel analyticsModelObj = AnalyticsModel();

  @override
  void dispose() {
    super.dispose();
  }
}
