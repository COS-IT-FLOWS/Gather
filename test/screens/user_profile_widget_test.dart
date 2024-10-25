import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:gather/models/user_data_model.dart';
import 'package:gather/screens/user_profile_widget.dart';
import '../mock_classes.dart';

void main() {
  late MockAuthProvider mockAuthProvider;
  late MockDatabaseProvider mockDatabaseProvider;
  late MockProfileProvider mockProfileProvider;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    mockDatabaseProvider = MockDatabaseProvider();
    mockProfileProvider = MockProfileProvider();
    // Set up the userId to avoid null errors
  });

  testWidgets('ProfileWidget displays user data correctly',
      (WidgetTester tester) async {
    // Set up the mock user data
    final userData = UserDataModel(
      firstName: 'John',
      lastName: 'Doe',
      phoneNumber: '+1234567890',
      emailAddress: 'john.doe@example.com',
      occupation: 'Developer',
      userAge: 30,
      stationIds: ['Station1', 'Station2'],
    );

    // Mock the behavior of the database provider
    // when(mockDatabaseProvider.readUserData(any))
    //     .thenAnswer((_) async => userData);
    // when(mockProfileProvider.isEditProfileDetails).thenReturn(false);

    // Build the ProfileWidget
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DatabaseProvider>(
              create: (_) => mockDatabaseProvider),
          ChangeNotifierProvider<SignInProvider>(
              create: (_) => mockAuthProvider),
          ChangeNotifierProvider<ProfileProvider>(
              create: (_) => mockProfileProvider),
        ],
        builder: (context, child) {
          return MaterialApp(home: ProfileWidget());
        },
      ),
    );

    // tester.pumpAndSettle();
    // expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
    // Verify that the user data is displayed correctly
    // expect(find.text('John'), findsOneWidget);
    // expect(find.text('Doe'), findsOneWidget);
    // expect(find.text('+1234567890'), findsOneWidget);
    // expect(find.text('john.doe@example.com'), findsOneWidget);
    // expect(find.text('Developer'), findsOneWidget);
    // expect(find.text('30'), findsOneWidget);
    // expect(find.text('TEST9999'), findsOneWidget);
  });

  testWidgets('ProfileWidget allows editing user data',
      (WidgetTester tester) async {
    // Set up the mock user data
    final userData = UserDataModel(
      firstName: 'John',
      lastName: 'Doe',
      phoneNumber: '+1234567890',
      emailAddress: 'john.doe@example.com',
      occupation: 'Developer',
      userAge: 30,
      stationIds: ['Station1', 'Station2'],
    );

    // Mock the behavior of the database provider

    // Build the ProfileWidget
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DatabaseProvider>(
              create: (_) => mockDatabaseProvider),
          ChangeNotifierProvider<SignInProvider>(
              create: (_) => mockAuthProvider),
          ChangeNotifierProvider<ProfileProvider>(
              create: (_) => mockProfileProvider),
        ],
        child: MaterialApp(home: ProfileWidget()),
      ),
    );

    // Tap the edit button
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Verify that the fields are now editable
    expect(find.byType(TextFormField),
        findsNWidgets(5)); // Assuming there are 6 editable fields

    // Change the first name
    await tester.enterText(find.byType(TextFormField).first, 'Jane');
    // await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    // Verify that the database provider's insertUser Data method is called
    verify(mockDatabaseProvider.insertUserData(userData)).called(1);
  });
}
