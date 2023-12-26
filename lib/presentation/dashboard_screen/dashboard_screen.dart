import 'models/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/widgets/app_bar/appbar_leading_image.dart';
import 'package:gather/widgets/app_bar/custom_app_bar.dart';
import 'provider/dashboard_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key})
      : super(
          key: key,
        );

  @override
  DashboardScreenState createState() => DashboardScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardProvider(),
      child: DashboardScreen(),
    );
  }
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgDashboard,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 5.v),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(
                  flex: 41,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgDefaultMarkerComponent,
                  height: 20.v,
                  width: 16.h,
                ),
                Spacer(
                  flex: 58,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgVectorBlack900,
        margin: EdgeInsets.fromLTRB(15.h, 11.v, 312.h, 11.v),
      ),
    );
  }
}
