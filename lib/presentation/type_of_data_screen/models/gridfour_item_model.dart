import '../../../core/app_export.dart';

/// This class is used in the [gridfour_item_widget] screen.
class GridfourItemModel {
  GridfourItemModel({
    this.circleImage,
    this.text,
    this.id,
  }) {
    circleImage = circleImage ?? ImageConstant.imgRectangle4;
    text = text ?? "RAINFALL";
    id = id ?? "";
  }

  String? circleImage;

  String? text;

  String? id;
}
