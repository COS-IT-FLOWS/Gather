import 'package:flutter/material.dart';
import 'package:gather/presentation/authentication_screen.dart';
import 'package:gather/presentation/dataentry_screen.dart';

class AppRoutes {
  static const String authenticationScreen = '/authentication_screen';

  static const String dataEntry = '/listView';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        authenticationScreen: authenticationScreen,
        dataEntry: dataEntry,
      };
}
