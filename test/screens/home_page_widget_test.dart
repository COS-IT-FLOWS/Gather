import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/main.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:gather/models/user_data_model.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:gather/screens/home_page_widget.dart';

// Mock classes
class MockAuthProvider extends Mock implements SignInProvider {}

class MockDatabaseProvider extends Mock implements DatabaseProvider {}

class MockProfileProvider extends Mock implements ProfileProvider {}

void main() {
  late MockAuthProvider mockAuthProvider;
  late MockDatabaseProvider mockDatabaseProvider;
  late MockProfileProvider mockProfileProvider;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    mockDatabaseProvider = MockDatabaseProvider();
    mockProfileProvider = MockProfileProvider();
    // when(mockAuthProvider.signInWithGoogle())
    //     .thenAnswer((_) async => 'testUserId');
    when(mockAuthProvider.userId).thenReturn('testUserId');
    when(mockDatabaseProvider.readUserData('testUserId'))
        .thenAnswer((_) async => UserDataModel(
              firstName: 'John',
              lastName: 'Doe',
              phoneNumber: '1234567890',
              emailAddress: 'john.doe@example.com',
              occupation: 'Developer',
              userAge: 30,
              stationIds: ['station1', 'station2'],
            ));
  });

  testWidgets('HomePageWidget displays loading indicator initially',
      (WidgetTester tester) async {
    // Arrange
    when(mockDatabaseProvider.readUserData(any))
        .thenAnswer((_) async => UserDataModel(
              firstName: 'John',
              lastName: 'Doe',
              phoneNumber: '1234567890',
              emailAddress: 'john.doe@example.com',
              occupation: 'Developer',
              userAge: 30,
              stationIds: ['station1', 'station2'],
            ));

    // Act
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SignInProvider>(
              create: (_) => mockAuthProvider),
          ChangeNotifierProvider<DatabaseProvider>(
              create: (_) => mockDatabaseProvider),
          ChangeNotifierProvider<ProfileProvider>(
              create: (_) => mockProfileProvider),
        ],
        builder: (context, child) {
          return MaterialApp(home: HomePageWidget());
        },
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomePageWidget displays error message on error',
      (WidgetTester tester) async {
    // Arrange
    when(mockDatabaseProvider.readUserData(any))
        .thenThrow(Exception('Error fetching data'));

    // Act
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SignInProvider>(
              create: (_) => mockAuthProvider),
          ChangeNotifierProvider<DatabaseProvider>(
              create: (_) => mockDatabaseProvider),
          ChangeNotifierProvider<ProfileProvider>(
              create: (_) => mockProfileProvider),
        ],
        child: MaterialApp(home: HomePageWidget()),
      ),
    );

    // Assert
    expect(find.text('Error: Exception: Error fetching data'), findsOneWidget);
  });

  testWidgets('HomePageWidget displays user data correctly',
      (WidgetTester tester) async {
    // Arrange

    // when(mockAuthProvider.signInWithGoogle())
    //     .thenAnswer((_) async => 'testUserId');
    when(mockDatabaseProvider.readUserData('testUserId'))
        .thenAnswer((_) async => UserDataModel(
              firstName: 'John',
              lastName: 'Doe',
              phoneNumber: '1234567890',
              emailAddress: 'john.doe@example.com',
              occupation: 'Developer',
              userAge: 30,
              stationIds: ['station1', 'station2'],
            ));

    // Act
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SignInProvider>(
              create: (_) => mockAuthProvider),
          ChangeNotifierProvider<DatabaseProvider>(
              create: (_) => mockDatabaseProvider),
          ChangeNotifierProvider<ProfileProvider>(
              create: (_) => mockProfileProvider),
        ],
        child: MaterialApp(home: HomePageWidget()),
      ),
    );

    // Assert
    expect(find.text('Rainfall'), findsOneWidget);
    expect(find.text('River'), findsOneWidget);
    expect(find.text('Groundwater'), findsOneWidget);
    expect(find.text('Tidal'), findsOneWidget);
  });
}
