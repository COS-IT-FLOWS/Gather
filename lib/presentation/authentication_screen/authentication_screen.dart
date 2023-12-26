import 'models/authentication_model.dart';
import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/widgets/custom_outlined_button.dart';
import 'package:gather/widgets/custom_text_form_field.dart';
import 'provider/authentication_provider.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  AuthenticationScreenState createState() => AuthenticationScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: AuthenticationScreen(),
    );
  }
}

class AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 29.h,
            vertical: 76.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 46.v),
              Padding(
                padding: EdgeInsets.only(left: 9.h),
                child: Text(
                  "lbl_phone_number".tr,
                  style: theme.textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 9.v),
              Selector<AuthenticationProvider, TextEditingController?>(
                selector: (
                  context,
                  provider,
                ) =>
                    provider.phoneNumberController,
                builder: (context, phoneNumberController, child) {
                  return CustomTextFormField(
                    controller: phoneNumberController,
                    hintText: "lbl_999_999_9999".tr,
                    textInputAction: TextInputAction.done,
                    suffix: Container(
                      padding: EdgeInsets.fromLTRB(12.h, 6.v, 12.h, 8.v),
                      margin: EdgeInsets.only(left: 30.h),
                      decoration: BoxDecoration(
                        color: appTheme.teal400,
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgForward,
                        height: 42.v,
                        width: 32.h,
                      ),
                    ),
                    suffixConstraints: BoxConstraints(
                      maxHeight: 57.v,
                    ),
                  );
                },
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 67.h),
                child: Text(
                  "lbl_or_sign_up_via".tr,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 16.v),
              _buildLoginRegisterRow(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginRegisterRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomOutlinedButton(
            width: 129.h,
            text: "lbl_google".tr,
            rightIcon: Container(
              margin: EdgeInsets.only(),
              child: CustomImageView(
                imagePath: ImageConstant.imgRectangle2,
                height: 53.v,
                width: 54.h,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 33.h,
              vertical: 13.v,
            ),
            decoration: AppDecoration.outlineBlack.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 6.v),
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle253x62,
                  height: 53.v,
                  width: 62.h,
                  alignment: Alignment.centerRight,
                ),
                SizedBox(height: 7.v),
                Text(
                  "lbl_mail".tr,
                  style: theme.textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
