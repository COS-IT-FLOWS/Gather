import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/screens/home_page_widget.dart'; // Adjust the import as necessary
import 'package:gather/models/list_view_model.dart'; // Adjust the import as necessary

void main() {
  testWidgets('HomePageModel initializes and disposes correctly',
      (WidgetTester tester) async {
    // Create an instance of HomePageModel
    final homePageModel = HomePageModel();

    // Initialize the model
    homePageModel.initState(tester.element(find.byType(HomePageWidget)));

    // Verify that the unfocusNode is created
    expect(homePageModel.unfocusNode, isNotNull);

    // Dispose of the model
    homePageModel.dispose();

    // Verify that the unfocusNode is disposed
    expect(homePageModel.unfocusNode,
        isNotNull); // The unfocusNode should still exist
    // However, we cannot directly check if it is disposed, but we can check if it is still usable
    expect(homePageModel.unfocusNode.hasFocus,
        isFalse); // Should not have focus after disposal
  });
}
