import 'package:flutter/material.dart';
import 'package:gather/core/app_export.dart';
import 'package:gather/presentation/data_entry_overlay_screen/models/data_entry_overlay_model.dart';

/// A provider class for the DataEntryOverlayScreen.
///
/// This provider manages the state of the DataEntryOverlayScreen, including the
/// current dataEntryOverlayModelObj
class DataEntryOverlayProvider extends ChangeNotifier {
  DataEntryOverlayModel dataEntryOverlayModelObj = DataEntryOverlayModel();

  @override
  void dispose() {
    super.dispose();
  }
}
