import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/data_text_form_widget.dart'; // Adjust the import based on your file structure
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/datetime_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:gather/screens/home_page_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import '../mock_classes.dart'; // Import your mock classes

void main() {
  group('DataTextFormWidget Tests', () {
    late MockDateTimeProvider mockDateTimeProvider;
    late MockDatabaseProvider mockDatabaseProvider;
    late MockProfileProvider mockProfileProvider;
    late MockAuthProvider mockAuthProvider;

    setUp(() {
      // Initialize mock providers
      mockDateTimeProvider = MockDateTimeProvider();
      mockDatabaseProvider = MockDatabaseProvider();
      mockProfileProvider = MockProfileProvider();
      mockAuthProvider = MockAuthProvider();
    });

    testWidgets('does not render for non gatherers',
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
            ChangeNotifierProvider<SignInProvider>(
                create: (_) => mockAuthProvider)
          ],
          builder: (context, child) {
            return MaterialApp(home: HomePageWidget());
          },
        ),
      );
      String userId = 'nontestUserId';
      mockAuthProvider.logIn(userId);
      mockProfileProvider.setStationIdsForUser(userId);
      await tester.pumpAndSettle();

      expect(find.text('Rainfall'), findsOneWidget);

      await tester.tap(find.text('Rainfall'));
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField),
          findsNothing); // Adjust based on number of text fields
      expect(find.text('Submit'), findsNothing);

      // Check if the initial UI is rendered
      expect(find.text('No Station ID Found'), findsOneWidget);
      expect(find.text('Please select a valid station ID'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // Try submitting the form without filling it

      // Check for validation error message
      expect(find.text('Enter Data'), findsOneWidget);
      expect(find.text('Rainfall'), findsOneWidget);
      expect(find.text('River'), findsOneWidget);
      expect(find.text('Groundwater'), findsOneWidget);
      expect(find.text('Tidal'), findsOneWidget);
    });

    testWidgets('renders correctly and validates input for gatherer',
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
            ChangeNotifierProvider<SignInProvider>(
                create: (_) => mockAuthProvider)
          ],
          builder: (context, child) {
            return MaterialApp(home: HomePageWidget());
          },
        ),
      );
      String userId = 'testUserId';
      mockAuthProvider.logIn(userId);
      mockProfileProvider.setStationIdsForUser(userId);
      await tester.pumpAndSettle();

      expect(find.text('Rainfall'), findsOneWidget);

      await tester.tap(find.text('Rainfall'));
      await tester.pumpAndSettle();
      // Check if the initial UI is rendered
      expect(
          find.text('Rainfall'), findsOneWidget); // Adjust based on your logic
      expect(find.byType(TextFormField),
          findsNWidgets(3)); // Adjust based on number of text fields

      // Try submitting the form without filling it
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Check for validation error message
      expect(find.text('Please enter a value'), findsOneWidget);
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
            ChangeNotifierProvider<SignInProvider>(
                create: (_) => mockAuthProvider)
          ],
          builder: (context, child) {
            return MaterialApp(home: HomePageWidget());
          },
        ),
      );
      String userId = 'testUserId';
      mockAuthProvider.logIn(userId);
      mockProfileProvider.setStationIdsForUser(userId);
      await tester.pumpAndSettle();

      expect(find.text('Rainfall'), findsOneWidget);

      await tester.tap(find.text('Rainfall'));
      await tester.pumpAndSettle();
      // expect(find.byType())
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
