import 'package:flutter/material.dart';
import 'package:gather/screens/dashboard_widget.dart';
import 'package:gather/screens/list_view_widget.dart';
import 'package:gather/screens/tab_view.dart';

import 'package:gather/screens/notification_widget.dart';
import 'package:gather/screens/auth_widget.dart';

class AppRoutes {
  // static const String home = '/';
  // static const String authScreen = '/';
  // static const String dataEntry = '/listView';
  // static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes() => {
        '/initialRoute': (BuildContext context) => AuthenticationWidget(),
        '/': (BuildContext context) => TabViewWidget(),
        '/dataTypes': (BuildContext context) => ListViewWidget(),
        '/dashboard': (BuildContext context) => DashboardWidget(),
        '/notifications': (BuildContext context) => NotificationWidget()
      };
}
