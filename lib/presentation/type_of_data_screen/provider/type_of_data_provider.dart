import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/presentation/type_of_data_screen/models/type_of_data_model.dart';
import '../models/grid_item_model.dart';

/// A provider class for the TypeOfDataScreen.
///
/// This provider manages the state of the TypeOfDataScreen, including the
/// current typeOfDataModelObj

// ignore_for_file: must_be_immutable
class TypeOfDataProvider extends ChangeNotifier {
  TypeOfDataModel typeOfDataModelObj = TypeOfDataModel();

  @override
  void dispose() {
    super.dispose();
  }
}
