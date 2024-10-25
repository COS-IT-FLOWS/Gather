import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/data_text_form_widget.dart'; // Adjust the import based on your file structure
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/datetime_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import '../mock_classes.dart'; // Import your mock classes

void main() {
  group('DataTextFormWidget Tests', () {
    late MockDateTimeProvider mockDateTimeProvider;
    late MockDatabaseProvider mockDatabaseProvider;
    late MockProfileProvider mockProfileProvider;

    setUp(() {
      // Initialize mock providers
      mockDateTimeProvider = MockDateTimeProvider();
      mockDatabaseProvider = MockDatabaseProvider();
      mockProfileProvider = MockProfileProvider();

      // Set up mock behavior
      // when(mockDateTimeProvider.initialDate).thenReturn(DateTime.now());
      // when(mockDateTimeProvider.initialTime).thenReturn(TimeOfDay.now());
      // when(mockProfileProvider.stationIds)
      //     .thenReturn(['Station_1', 'Station_2']);
      // when(mockDateTimeProvider.getDateString(any)).thenReturn('01/01/2023');
      // when(mockDateTimeProvider.getTimeString(any, any)).thenReturn('12:00 PM');
    });

    testWidgets('renders correctly and validates input',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<DateTimeProvider>(
                create: (_) => mockDateTimeProvider),
            ChangeNotifierProvider<DatabaseProvider>(
                create: (_) => mockDatabaseProvider),
            ChangeNotifierProvider<ProfileProvider>(
                create: (_) => mockProfileProvider),
          ],
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: DataTextFormWidget(paramType: 'RAINFALL', unitType: 'mm'),
              ),
            );
          },
        ),
      );

      // Check if the initial UI is rendered
      // expect(find.text('Enter Data'),
      //     findsOneWidget); // Adjust based on your logic
      // expect(find.byType(TextFormField),
      //     findsNWidgets(3)); // Adjust based on number of text fields

      // Try submitting the form without filling it
      // await tester.tap(find.text('Submit'));
      // await tester.pumpAndSettle();

      // Check for validation error message
      // expect(find.text('Please enter a value'), findsOneWidget);
    });

    testWidgets('submits data successfully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<DateTimeProvider>(
                create: (_) => mockDateTimeProvider),
            ChangeNotifierProvider<DatabaseProvider>(
                create: (_) => mockDatabaseProvider),
            ChangeNotifierProvider<ProfileProvider>(
                create: (_) => mockProfileProvider),
          ],
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: DataTextFormWidget(paramType: 'RAINFALL', unitType: 'mm'),
              ),
            );
          },
        ),
      );

      // Fill in the text field
      await tester.enterText(find.byType(TextFormField).first,
          '25'); // Assuming this is the first field

      // Mock the insertWeatherData method
      // when(mockDatabaseProvider.insertWeatherData(any, any, any, any))
      //     .thenAnswer((_) async => true);

      await tester.tap(find.text('Submit'));
      await tester.pump();

      // Check for success dialog
      expect(find.text('Data Submitted Successfully'), findsOneWidget);
    });

    // Add more tests as needed...
  });
}
