import '../type_of_data_screen/widgets/gridfour_item_widget.dart';
import 'models/gridfour_item_model.dart';
import 'models/type_of_data_model.dart';
import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/widgets/app_bar/appbar_leading_image.dart';
import 'package:gather/widgets/app_bar/appbar_title_image.dart';
import 'package:gather/widgets/app_bar/appbar_trailing_image.dart';
import 'package:gather/widgets/app_bar/custom_app_bar.dart';
import 'provider/type_of_data_provider.dart';

class TypeOfDataScreen extends StatefulWidget {
  const TypeOfDataScreen({Key? key}) : super(key: key);

  @override
  TypeOfDataScreenState createState() => TypeOfDataScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TypeOfDataProvider(), child: TypeOfDataScreen());
  }
}

class TypeOfDataScreenState extends State<TypeOfDataScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(height: 5.v),
                  _buildGridFour(context)
                ])),
            bottomNavigationBar: _buildStackFive(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 72.v,
        leadingWidth: 44.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgMegaphone,
            margin: EdgeInsets.only(left: 11.h, top: 24.v, bottom: 15.v)),
        centerTitle: true,
        title: AppbarTitleImage(
            imagePath: ImageConstant.imgDashboard1,
            onTap: () {
              onTapDashboardOne(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgLock,
              margin: EdgeInsets.fromLTRB(23.h, 24.v, 23.h, 15.v),
              onTap: () {
                onTapLock(context);
              })
        ],
        styleType: Style.bgShadow);
  }

  /// Section Widget
  Widget _buildGridFour(BuildContext context) {
    return Container(
        decoration: AppDecoration.fillWhiteA,
        child:
            Consumer<TypeOfDataProvider>(builder: (context, provider, child) {
          return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 150.v,
                  crossAxisCount: 2,
                  mainAxisSpacing: 83.h,
                  crossAxisSpacing: 83.h),
              physics: NeverScrollableScrollPhysics(),
              itemCount: provider.typeOfDataModelObj.gridfourItemList.length,
              itemBuilder: (context, index) {
                GridfourItemModel model =
                    provider.typeOfDataModelObj.gridfourItemList[index];
                return GridfourItemWidget(model, onTapImgCircleImage: () {
                  onTapImgCircleImage(context);
                });
              });
        }));
  }

  /// Section Widget
  Widget _buildStackFive(BuildContext context) {
    return Container(
        height: 6.v,
        width: 120.h,
        margin: EdgeInsets.only(left: 120.h, right: 120.h, bottom: 9.v),
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: 120.h,
                  child: Divider(color: theme.colorScheme.onPrimary))),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: 120.h,
                  child: Divider(color: theme.colorScheme.onPrimary)))
        ]));
  }

  /// Navigates to the dataEntryOverlayScreen when the action is triggered.
  onTapImgCircleImage(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.dataEntryOverlayScreen);
  }

  /// Navigates to the dashboardScreen when the action is triggered.
  onTapDashboardOne(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.dashboardScreen,
    );
  }

  /// Navigates to the profileScreen when the action is triggered.
  onTapLock(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.profileScreen,
    );
  }
}
