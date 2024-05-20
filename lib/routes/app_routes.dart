import 'package:flutter/material.dart';
import 'package:gather/screens/dashboard_widget.dart';
import 'package:gather/screens/home_page_widget.dart';
import 'package:gather/screens/event_report_widget.dart';
import 'package:gather/screens/user_profile_widget.dart';
// import 'package:gather/screens/tab_view_widget.dart.backup';

import 'package:gather/screens/notification_widget.dart';
import 'package:gather/screens/auth_widget.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes() => {
        '/initialRoute': (BuildContext context) => AuthenticationWidget(),
        '/': (BuildContext context) => HomePageWidget(),
        // '/homePage': (BuildContext context) => HomePageWidget(),
        '/dashboard': (BuildContext context) => DashboardWidget(),
        '/notifications': (BuildContext context) => NotificationWidget(),
        '/eventreport': (BuildContext context) => EventReportWidget(),
        '/profile': (BuildContext context) => ProfileWidget()
      };
}
