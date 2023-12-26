import 'package:flutter/material.dart';
import 'package:gather/presentation/authentication_screen/authentication_screen.dart';
import 'package:gather/presentation/analytics_screen/analytics_screen.dart';
import 'package:gather/presentation/logo_screen/logo_screen.dart';
import 'package:gather/presentation/profile_screen/profile_screen.dart';
import 'package:gather/presentation/otp_overlay_screen/otp_overlay_screen.dart';
import 'package:gather/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:gather/presentation/data_entry_overlay_screen/data_entry_overlay_screen.dart';
import 'package:gather/presentation/type_of_data_screen/type_of_data_screen.dart';
import 'package:gather/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String authenticationScreen = '/authentication_screen';

  static const String analyticsScreen = '/analytics_screen';

  static const String logoScreen = '/logo_screen';

  static const String profileScreen = '/profile_screen';

  static const String otpOverlayScreen = '/otp_overlay_screen';

  static const String dashboardScreen = '/dashboard_screen';

  static const String dataEntryOverlayScreen = '/data_entry_overlay_screen';

  static const String typeOfDataScreen = '/type_of_data_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        authenticationScreen: AuthenticationScreen.builder,
        analyticsScreen: AnalyticsScreen.builder,
        logoScreen: LogoScreen.builder,
        profileScreen: ProfileScreen.builder,
        otpOverlayScreen: OtpOverlayScreen.builder,
        dashboardScreen: DashboardScreen.builder,
        dataEntryOverlayScreen: DataEntryOverlayScreen.builder,
        typeOfDataScreen: TypeOfDataScreen.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: AuthenticationScreen.builder
      };
}
