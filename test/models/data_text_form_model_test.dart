import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/data_text_form_widget.dart'; // Adjust the import as necessary
import 'package:gather/models/data_text_form_model.dart';
import 'package:mockito/mockito.dart'; // Adjust the import as necessary

void main() {
  group('DataTextFormModel', () {
    test('should initialize without errors', () {
      // Arrange
      final dataTextFormModel = DataTextFormModel();

      // Act
      dataTextFormModel.initState(MockBuildContext());

      // Assert
      expect(dataTextFormModel.textFieldFocusNode, isNull);
      expect(dataTextFormModel.textController, isNull);
      expect(dataTextFormModel.textControllerValidator, isNull);
    });

    test('should dispose of FocusNode and TextEditingController', () {
      // Arrange
      final dataTextFormModel = DataTextFormModel();
      dataTextFormModel.textFieldFocusNode = FocusNode();
      dataTextFormModel.textController = TextEditingController();

      // Act
      dataTextFormModel.dispose();

      // Assert
      expect(dataTextFormModel.textFieldFocusNode,
          isNotNull); // The node should still exist
      expect(dataTextFormModel.textFieldFocusNode!.hasFocus,
          isFalse); // Should not have focus after disposal
      expect(dataTextFormModel.textController,
          isNotNull); // The controller should still exist
      expect(dataTextFormModel.textController!.text,
          ''); // Should be empty after disposal
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
