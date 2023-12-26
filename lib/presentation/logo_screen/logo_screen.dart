import 'models/logo_model.dart';
import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'provider/logo_provider.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  LogoScreenState createState() => LogoScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogoProvider(),
      child: LogoScreen(),
    );
  }
}

class LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 44.v),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgCommuniy2,
                height: 227.v,
                width: 235.h,
              ),
              SizedBox(height: 45.v),
              CustomImageView(
                imagePath: ImageConstant.imgEquinoctLogo,
                height: 214.v,
                width: 212.h,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}
