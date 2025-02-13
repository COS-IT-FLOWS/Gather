import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/appbar_widget.dart';
import 'package:gather/screens/about_us_widget.dart'; // Adjust the import based on your file structure

void main() {
  testWidgets('AboutUsPage has correct structure', (WidgetTester tester) async {
    // Build the AboutUsPage
    await tester.pumpWidget(
      MaterialApp(
        home: AboutUsPage(),
      ),
    );

    // Verify the app bar title
    expect(find.text('About Us'), findsOneWidget);

    // Verify the presence of the first image
    expect(find.byType(Image), findsNWidgets(2)); // Expecting two images
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                "assets/logos/gather_splash.png"),
        findsOneWidget);

    // Verify the description text
    expect(find.textContaining('Gather is an open source application'),
        findsOneWidget);

    // Verify the presence of the second image
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                "assets/logos/equinoct_logo.png"),
        findsOneWidget);
  });
}
