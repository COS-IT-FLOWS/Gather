import 'package:flutter/material.dart';
// import 'package:gather/screens/dashboard_widget.dart.backup';
// import 'package:gather/screens/dashboard_widget.dart.backup';
import 'package:gather/screens/home_page_widget.dart';
import 'package:gather/screens/event_report_widget.dart';
import 'package:gather/screens/otp_input_widget.dart';
import 'package:gather/screens/user_profile_widget.dart';
import 'package:gather/screens/notification_widget.dart';
// import 'package:gather/screens/tab_view_widget.dart.backup';
import 'package:provider/provider.dart';
import 'package:gather/screens/notification_widget.dart';
import 'package:gather/screens/auth_widget.dart';
import 'package:gather/providers.dart';

class AppRoutes {
  // static Route<dynamic> routes(RouteSettings settings) {
  //   final authProvider =
  //       Provider.of<SignInProvider>(settings.context, listen: false);
  //   switch (settings.name) {
  //     case '/':return MaterialPageRoute(builder: (context));
  //     case '/auth':return MaterialPageRoute(builder: (context) => AuthenticationWidget());
  //     case '/home':return MaterialPageRoute(builder: (context) => HomePageWidget());
  //     default: return null;
  //   }
  // }

  static Map<String, WidgetBuilder> routes() => {
        '/authentication': (BuildContext context) => AuthenticationWidget(),
        '/otpscreen': (BuildContext context) => OtpInputWidget(),
        '/home': (BuildContext context) => HomePageWidget(),
        // '/otp': (BuildContext context) => OtpInputWidget(onChanged:
        // '/dashboard': (BuildContext context) => DashboardWidget(),
        '/notifications': (BuildContext context) => NotificationWidget(),
        '/eventreport': (BuildContext context) => EventReportWidget(),
        '/profile': (BuildContext context) => ProfileWidget()
      };
}
