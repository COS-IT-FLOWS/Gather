import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../components/data_text_form_widget.dart' show DataTextFormWidget;
import 'package:flutter/material.dart';

class DataTextFormModel extends FlutterFlowModel<DataTextFormWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
