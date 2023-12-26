import '../../../core/app_export.dart';

/// This class is used in the [grid_item_widget] screen.
class GridItemModel {
  GridItemModel({
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
