import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/hazard_type_question.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:gather/screens/event_report_widget.dart'; // Adjust the import based on your file structure
import '../mock_classes.dart'; // Import your mock classes
// import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:gather/models/hazard_data_model.dart';

void main() {
  final GlobalConfiguration configuration = GlobalConfiguration();
  late MockDatabaseProvider mockDatabaseProvider;
  late MockImagePicker mockImagePicker;

  setUp(() async {
    mockDatabaseProvider = MockDatabaseProvider();
    mockImagePicker = MockImagePicker();
    // WidgetsFlutterBinding.ensureInitialized();
    await configuration.loadFromAsset('app_settings');
  });

  testWidgets('EventReportWidget displays UI elements correctly',
      (WidgetTester tester) async {
    // Create a mock database provider
    await tester.pumpWidget(
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => mockDatabaseProvider,
          builder: (context, child) {
            return MaterialApp(
                home: EventReportWidget(
                    picker: mockImagePicker, config: configuration));
          }),
    );
    // await tester.pumpAndSettle();

    // Verify that the title is displayed
    expect(find.text('Report Hazard'), findsOneWidget);
    expect(
        find.text(
            'Report extreme weather phenomena such as floods, flash floods, landslides, heatwaves, etc.'),
        findsOneWidget);
    expect(find.text('Select type of hazard event:'), findsOneWidget);
    expect(find.text('River Flood'), findsOneWidget);
    expect(find.text('Tidal Flood'), findsOneWidget);
    expect(find.text('Flash Flood'), findsOneWidget);
    expect(find.text('Earthquake'), findsOneWidget);
    expect(find.text('Landslide'), findsOneWidget);
    expect(find.text('Fire Hazard'), findsOneWidget);
    expect(find.text('Others'), findsOneWidget);

    expect(find.byType(RadioListTile<String>), findsNWidgets(7));

    expect(find.text('Upload Photo'), findsOneWidget);
    expect(find.text('Open Camera'), findsOneWidget);
    expect(find.text('No images selected'), findsOneWidget);
    expect(find.text('Short description of hazard'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('EventReportWidget handles image selection',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => mockDatabaseProvider,
          builder: (context, child) {
            return MaterialApp(
                home: EventReportWidget(
              picker: mockImagePicker,
              config: configuration,
            ));
          }),
    );
    await tester.pumpAndSettle();

    expect(find.text('Upload Photo'), findsOneWidget);

    final itemFinder = find.byKey(Key('photo-upload'));
    await tester.ensureVisible(itemFinder);

    // Simulate image selection
    // You would typically use a package like `mockito` to mock the ImagePicker behavior
    // For this example, we will just simulate the image selection directly
    await tester.tap(find.byKey(Key('photo-upload')));
    await tester.pumpAndSettle();

    // Simulate picking an image

    // Verify that the image is added to the widget
    expect(find.text('No images selected'), findsNothing);
  });

  testWidgets('EventReportWidget handles photo capture',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => mockDatabaseProvider,
          builder: (context, child) {
            return MaterialApp(
                home: EventReportWidget(
              picker: mockImagePicker,
              config: configuration,
            ));
          }),
    );

    await tester.pumpAndSettle();

    expect(find.text('Open Camera'), findsOneWidget);

    final itemFinder = find.byKey(Key('camera-upload'));
    await tester.ensureVisible(itemFinder);

    // Simulate image selection
    // You would typically use a package like `mockito` to mock the ImagePicker behavior
    // For this example, we will just simulate the image selection directly
    await tester.tap(find.byKey(Key('camera-upload')));
    await tester.pumpAndSettle();

    // Verify that the image is added to the widget
    expect(find.text('No images selected'), findsNothing);
  });

  testWidgets('EventReportWidget submits data successfully',
      (WidgetTester tester) async {
    // Set up the mock to return a hazard ID

    await tester.pumpWidget(
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => mockDatabaseProvider,
          builder: (context, child) {
            return MaterialApp(
                home: EventReportWidget(
                    picker: mockImagePicker, config: configuration));
          }),
    );

    expect(find.text('River Flood'), findsOneWidget);
    await (tester.tap(find.text('River Flood')));

    expect(find.text('Select type of hazard event:'), findsOneWidget);
    // Fill in the hazard description
    await tester.enterText(find.byType(TextField), 'Flood in the area');

    // Simulate submission
    final itemFinder = find.byKey(Key('submit-report'));
    await tester.ensureVisible(itemFinder);
    await tester.tap(itemFinder);
    await tester.pump();

    // Verify that the success dialog is displayed
    expect(find.text('Data Submitted Successfully'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // expect(find.text('Rainfall'), findsOneWidget);
  });

  testWidgets('EventReportWidget audio recording', (WidgetTester tester) async {
    final mockDatabaseProvider = MockDatabaseProvider();
    final mockImagePicker = MockImagePicker();
    await tester.pumpWidget(
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => mockDatabaseProvider,
          builder: (context, child) {
            return MaterialApp(
                home: EventReportWidget(
              picker: mockImagePicker,
              config: configuration,
            ));
          }),
    );

    // Simulate taking a photo
    await tester.tap(find.text('Open Camera'));
    await tester.pumpAndSettle();

    // Verify that the image is added to the widget
    expect(find.text('No images selected'), findsOneWidget);
  });
}
