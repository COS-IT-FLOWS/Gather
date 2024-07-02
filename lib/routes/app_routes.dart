import 'package:flutter/material.dart';
// import 'package:gather/screens/dashboard_widget.dart.backup';
import 'package:gather/screens/home_page_widget.dart';
import 'package:gather/screens/event_report_widget.dart';
import 'package:gather/screens/otp_input_widget.dart';
import 'package:gather/screens/user_profile_widget.dart';
// import 'package:gather/screens/tab_view_widget.dart.backup';

import 'package:gather/screens/notification_widget.dart';
import 'package:gather/screens/auth_widget.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes() => {
        '/authentication': (BuildContext context) => AuthenticationWidget(),
        '/otpscreen': (BuildContext context) => OtpInputWidget(),
        '/': (BuildContext context) => HomePageWidget(),
        // '/otp': (BuildContext context) => OtpInputWidget(onChanged:
        // '/dashboard': (BuildContext context) => DashboardWidget(),
        '/notifications': (BuildContext context) => NotificationWidget(),
        '/eventreport': (BuildContext context) => EventReportWidget(),
        '/profile': (BuildContext context) => ProfileWidget()
      };
}
