import 'models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/widgets/app_bar/appbar_leading_image.dart';
import 'package:gather/widgets/app_bar/custom_app_bar.dart';
import 'provider/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key})
      : super(
          key: key,
        );

  @override
  ProfileScreenState createState() => ProfileScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: ProfileScreen(),
    );
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 8.h,
            vertical: 19.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileName(context),
              SizedBox(height: 36.v),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 48.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "lbl_age".tr,
                        style: theme.textTheme.headlineSmall,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 28.v),
                        child: SizedBox(
                          width: 182.h,
                          child: Divider(
                            indent: 21.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 33.v),
              Padding(
                padding: EdgeInsets.only(left: 53.h),
                child: Text(
                  "lbl_email".tr,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 2.v),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 209.h,
                  child: Divider(
                    endIndent: 48.h,
                  ),
                ),
              ),
              SizedBox(height: 33.v),
              Container(
                height: 29.v,
                width: 68.h,
                margin: EdgeInsets.only(left: 48.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "lbl_phone".tr,
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "lbl_phone".tr,
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.v),
              Padding(
                padding: EdgeInsets.only(right: 48.h),
                child: _buildProfileOccupationLines(context),
              ),
              SizedBox(height: 36.v),
              _buildProfileOccupation(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildStackLines(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgLine5,
        margin: EdgeInsets.fromLTRB(11.h, 26.v, 305.h, 26.v),
      ),
    );
  }

  /// Section Widget
  Widget _buildProfileName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 48.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 48.h),
            child: Text(
              "lbl_name".tr,
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 1.v),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 161.h,
              child: Divider(),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProfileOccupation(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 48.h),
      child: Row(
        children: [
          Text(
            "lbl_occupation".tr,
            style: theme.textTheme.headlineSmall,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 13.h,
              top: 28.v,
            ),
            child: _buildProfileOccupationLines(context),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStackLines(BuildContext context) {
    return Container(
      height: 6.v,
      width: 120.h,
      margin: EdgeInsets.only(
        left: 120.h,
        right: 120.h,
        bottom: 9.v,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 120.h,
              child: Divider(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 120.h,
              child: Divider(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildProfileOccupationLines(BuildContext context) {
    return SizedBox(
      height: 1.v,
      width: 161.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 161.h,
              child: Divider(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 161.h,
              child: Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
