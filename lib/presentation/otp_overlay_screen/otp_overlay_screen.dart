import 'models/otp_overlay_model.dart';
import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/widgets/custom_elevated_button.dart';
import 'provider/otp_overlay_provider.dart';

class OtpOverlayScreen extends StatefulWidget {
  const OtpOverlayScreen({Key? key}) : super(key: key);

  @override
  OtpOverlayScreenState createState() => OtpOverlayScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => OtpOverlayProvider(), child: OtpOverlayScreen());
  }
}

class OtpOverlayScreenState extends State<OtpOverlayScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: 351.h,
                padding: EdgeInsets.symmetric(horizontal: 55.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 211.h,
                          margin: EdgeInsets.only(right: 27.h),
                          child: Text("msg_we_have_sent_an".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleLarge)),
                      SizedBox(height: 23.v),
                      CustomImageView(
                          imagePath: ImageConstant.img2,
                          height: 63.adaptSize,
                          width: 63.adaptSize,
                          alignment: Alignment.center),
                      SizedBox(height: 25.v),
                      CustomElevatedButton(text: "lbl_xxxx".tr),
                      SizedBox(height: 28.v),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.only(left: 17.h),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: 65.h,
                                        margin: EdgeInsets.only(
                                            top: 6.v, bottom: 7.v),
                                        child: Text("lbl_resend_otp".tr,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.titleLarge)),
                                    CustomElevatedButton(
                                        height: 61.v,
                                        width: 126.h,
                                        text: "msg_enter_otp_manually".tr,
                                        margin: EdgeInsets.only(left: 30.h),
                                        buttonStyle:
                                            CustomButtonStyles.fillLightBlue,
                                        buttonTextStyle:
                                            theme.textTheme.titleLarge!,
                                        onPressed: () {
                                          onTapEnterOTPManually(context);
                                        })
                                  ]))),
                      SizedBox(height: 1.v)
                    ]))));
  }

  onTapEnterOTPManually(BuildContext context) {
    // TODO: implement Actions
  }
}
