import 'package:flutter/material.dart';
import 'package:gather/screens/list_view_widget.dart';

// import 'package:gather/screens/home_screen.dart';
import 'package:gather/screens/auth_widget.dart';
import 'package:gather/models/list_view_model.dart';

class AppRoutes {
  // static const String home = '/';
  static const String authScreen = '/';
  static const String dataEntry = '/listView';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes() => {
        //Methods home: (BuildContext context) => HomeScreen(),
        authScreen: (BuildContext context) => AuthenticationWidget(),
        dataEntry: (BuildContext context) => ListViewWidget(),
      };
}
