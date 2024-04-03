import 'package:flutter/material.dart';
import 'package:gather/routes/app_routes.dart';

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
      routes: AppRoutes.routes(),
      initialRoute: '/',
      //       scaffoldMessengerKey: globalMessengerKey,
    );
  }
}
