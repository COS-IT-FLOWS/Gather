import '../../../core/app_export.dart';
import 'grid_item_model.dart';

class TypeOfDataModel {
  List<GridItemModel> gridItemList = [
    GridItemModel(circleImage: ImageConstant.imgRectangle4, text: "RAINFALL"),
    GridItemModel(
        circleImage: ImageConstant.imgRectangle4101x102, text: "RIVER"),
    GridItemModel(
        circleImage: ImageConstant.imgRectangle41, text: "WELL WATER"),
    GridItemModel(circleImage: ImageConstant.imgRectangle42, text: "TIDAL")
  ];
}
