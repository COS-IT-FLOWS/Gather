import 'models/data_entry_overlay_model.dart';
import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'provider/data_entry_overlay_provider.dart';

class DataEntryOverlayScreen extends StatefulWidget {
  const DataEntryOverlayScreen({Key? key})
      : super(
          key: key,
        );

  @override
  DataEntryOverlayScreenState createState() => DataEntryOverlayScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataEntryOverlayProvider(),
      child: DataEntryOverlayScreen(),
    );
  }
}

class DataEntryOverlayScreenState extends State<DataEntryOverlayScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 350.h,
          padding: EdgeInsets.symmetric(
            horizontal: 9.h,
            vertical: 11.v,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 17.h,
              vertical: 59.v,
            ),
            decoration: AppDecoration.outlineBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 43.v),
                _buildRowWithCircleImages(context),
                SizedBox(height: 41.v),
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse3,
                  height: 108.adaptSize,
                  width: 108.adaptSize,
                  radius: BorderRadius.circular(
                    54.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowWithCircleImages(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEllipse2,
            height: 108.adaptSize,
            width: 108.adaptSize,
            radius: BorderRadius.circular(
              54.h,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgEllipse4,
            height: 108.adaptSize,
            width: 108.adaptSize,
            radius: BorderRadius.circular(
              54.h,
            ),
          ),
        ],
      ),
    );
  }
}
