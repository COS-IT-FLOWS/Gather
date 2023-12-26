import 'models/analytics_model.dart';
import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/widgets/custom_outlined_button.dart';
import 'provider/analytics_provider.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  AnalyticsScreenState createState() => AnalyticsScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnalyticsProvider(),
      child: AnalyticsScreen(),
    );
  }
}

class AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.teal80099,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 14.v),
              CustomOutlinedButton(
                height: 83.v,
                width: 128.h,
                text: "lbl_39_mm".tr,
                buttonStyle: CustomButtonStyles.outlineBlack1,
                buttonTextStyle: CustomTextStyles.displaySmallWhiteA700,
                alignment: Alignment.centerRight,
              ),
              SizedBox(height: 24.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.v,
                      bottom: 55.v,
                    ),
                    child: Text(
                      "lbl_rainfall".tr,
                      style: CustomTextStyles.titleLargeOnPrimaryContainer,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDoctorReviews(context),
                          SizedBox(height: 6.v),
                          Padding(
                            padding: EdgeInsets.only(left: 115.h),
                            child: Text(
                              "lbl_time".tr,
                              style:
                                  CustomTextStyles.titleLargeOnPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                height: 6.v,
                width: 120.h,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDoctorReviews(BuildContext context) {
    return SizedBox(
      height: 108.v,
      width: 294.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgVector,
            height: 108.v,
            width: 294.h,
            alignment: Alignment.center,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgVectorPrimarycontainer,
            height: 108.v,
            width: 294.h,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
