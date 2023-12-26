import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/presentation/dashboard_screen/models/dashboard_model.dart';

/// A provider class for the DashboardScreen.
///
/// This provider manages the state of the DashboardScreen, including the
/// current dashboardModelObj
class DashboardProvider extends ChangeNotifier {
  DashboardModel dashboardModelObj = DashboardModel();

  @override
  void dispose() {
    super.dispose();
  }
}
