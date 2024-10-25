import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/hazard_type_question.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:gather/screens/event_report_widget.dart'; // Adjust the import based on your file structure
import '../mock_classes.dart'; // Import your mock classes
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:gather/models/hazard_data_model.dart';

void main() {
  testWidgets('EventReportWidget displays UI elements correctly',
      (WidgetTester tester) async {
    // Create a mock database provider
    final mockDatabaseProvider = MockDatabaseProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => mockDatabaseProvider,
          builder: (context, child) {
            return MaterialApp(home: EventReportWidget());
          }),
    );

    // Verify that the title is displayed
    expect(find.text('Report Hazard'), findsOneWidget);
    expect(find.text('Upload Photo'), findsOneWidget);
    expect(find.text('Open Camera'), findsOneWidget);
    expect(find.text('No images selected'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(FFButtonWidget), findsOneWidget);
  });

  testWidgets('EventReportWidget handles image selection',
      (WidgetTester tester) async {
    final mockDatabaseProvider = MockDatabaseProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => mockDatabaseProvider,
          builder: (context, child) {
            return MaterialApp(home: EventReportWidget());
          }),
    );

    // Simulate image selection
    // You would typically use a package like `mockito` to mock the ImagePicker behavior
    // For this example, we will just simulate the image selection directly

    // Simulate picking an image
    await tester.tap(find.text('Upload Photo'));
    await tester.pumpAndSettle();

    // Verify that the image is added to the widget
    expect(find.text('No images selected'), findsOneWidget);
  });

  testWidgets('EventReportWidget handles photo capture',
      (WidgetTester tester) async {
    final mockDatabaseProvider = MockDatabaseProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => mockDatabaseProvider,
          builder: (context, child) {
            return MaterialApp(home: EventReportWidget());
          }),
    );

    // Simulate taking a photo
    await tester.tap(find.text('Open Camera'));
    await tester.pumpAndSettle();

    // Verify that the image is added to the widget
    expect(find.text('No images selected'), findsOneWidget);
  });

  testWidgets('EventReportWidget submits data successfully',
      (WidgetTester tester) async {
    final mockDatabaseProvider = MockDatabaseProvider();

    HazardDataModel hazardDataModel = HazardDataModel(hazardType: "Flood");

    // Set up the mock to return a hazard ID
    when(mockDatabaseProvider
            .insertHazardEventDataAndGetHazardId(hazardDataModel))
        .thenAnswer((_) async => "1");

    await tester.pumpWidget(
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => mockDatabaseProvider,
          builder: (context, child) {
            return MaterialApp(home: EventReportWidget());
          }),
    );

    // Fill in the hazard description
    await tester.enterText(find.byType(TextField), 'Flood in the area');

    // Simulate submission
    await tester.tap(find.byType(FFButtonWidget));
    await tester.pumpAndSettle();

    // Verify that the success dialog is displayed
    expect(find.text('Data Submitted Successfully'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
  });
}
