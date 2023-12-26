import '../../../core/app_export.dart';
import 'gridfour_item_model.dart';

class TypeOfDataModel {
  List<GridfourItemModel> gridfourItemList = [
    GridfourItemModel(
        circleImage: ImageConstant.imgRectangle4, text: "RAINFALL"),
    GridfourItemModel(
        circleImage: ImageConstant.imgRectangle4101x102, text: "RIVER"),
    GridfourItemModel(
        circleImage: ImageConstant.imgRectangle41, text: "WELL WATER"),
    GridfourItemModel(circleImage: ImageConstant.imgRectangle42, text: "TIDAL")
  ];
}
