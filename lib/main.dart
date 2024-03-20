import 'package:flutter/material.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // onGenerateRoute: AppRoutes.generateRoute,
      scaffoldMessengerKey: globalMessengerKey,
    );
  }
}
