import '../models/grid_item_model.dart';
import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';

// ignore: must_be_immutable
class GridItemWidget extends StatelessWidget {
  GridItemWidget(
    this.gridItemModelObj, {
    Key? key,
    this.onTapImgCircleImage,
  }) : super(
          key: key,
        );

  GridItemModel gridItemModelObj;

  VoidCallback? onTapImgCircleImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.outlineBlack9001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder51,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: gridItemModelObj?.circleImage,
            height: 101.v,
            width: 102.h,
            radius: BorderRadius.circular(
              50.h,
            ),
            onTap: () {
              onTapImgCircleImage!.call();
            },
          ),
          SizedBox(height: 24.v),
          Text(
            gridItemModelObj.text!,
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
