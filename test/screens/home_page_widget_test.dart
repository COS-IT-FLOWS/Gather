import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/main.dart';
import 'package:gather/providers/datetime_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:gather/models/user_data_model.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:gather/screens/home_page_widget.dart';
import '../mock_classes.dart';
// Mock classes

void main() {
  late MockAuthProvider mockAuthProvider;
  late MockDatabaseProvider mockDatabaseProvider;
  late MockProfileProvider mockProfileProvider;
  late MockDateTimeProvider mockDateTimeProvider;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    mockDatabaseProvider = MockDatabaseProvider();
    mockProfileProvider = MockProfileProvider();
    mockDateTimeProvider = MockDateTimeProvider();
  });

  testWidgets('HomePageWidget displays loading indicator initially',
      (WidgetTester tester) async {
    // Arrange

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

    mockAuthProvider.logIn('testUserId');
    // await tester.pumpAndSettle();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomePageWidget displays error message on error',
      (WidgetTester tester) async {
    // Arrange

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
    expect(find.text('Rainfall'), findsNothing);
  });

  testWidgets('HomePageWidget displays all station types',
      (WidgetTester tester) async {
    // Arrange

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
    mockAuthProvider.logIn('testUserId');
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Enter Data'), findsOneWidget);
    expect(find.text('Rainfall'), findsOneWidget);
    expect(find.text('River'), findsOneWidget);
    expect(find.text('Groundwater'), findsOneWidget);
    expect(find.text('Tidal'), findsOneWidget);
  });

  testWidgets('HomePageWidget displays data entry form for params',
      (WidgetTester tester) async {
    // Arrange

    // when(mockAuthProvider.signInWithGoogle())
    //     .thenAnswer((_) async => 'testUserId');

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
          ChangeNotifierProvider<DateTimeProvider>(
              create: (_) => mockDateTimeProvider)
        ],
        child: MaterialApp(home: HomePageWidget()),
      ),
    );
    String userId = 'testUserId';
    mockAuthProvider.logIn(userId);
    mockProfileProvider.setStationIdsForUser(userId);
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Rainfall'), findsOneWidget);
    expect(find.text('River'), findsOneWidget);
    expect(find.text('Groundwater'), findsOneWidget);
    expect(find.text('Tidal'), findsOneWidget);

    await tester.tap(find.text('Rainfall'));
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('mm'), findsOneWidget);
    expect(find.text('Rainfall'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
    expect(find.text('TEST9999'), findsOneWidget);
  });

  testWidgets(
      'HomePageWidget displays data no station ID found for non members',
      (WidgetTester tester) async {
    // Arrange

    // when(mockAuthProvider.signInWithGoogle())
    //     .thenAnswer((_) async => 'testUserId');

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
          ChangeNotifierProvider<DateTimeProvider>(
              create: (_) => mockDateTimeProvider)
        ],
        child: MaterialApp(home: HomePageWidget()),
      ),
    );
    String userId = 'nonTestUserId';
    mockAuthProvider.logIn(userId);
    mockProfileProvider.setStationIdsForUser(userId);
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Rainfall'), findsOneWidget);
    expect(find.text('River'), findsOneWidget);
    expect(find.text('Groundwater'), findsOneWidget);
    expect(find.text('Tidal'), findsOneWidget);

    await tester.tap(find.text('Rainfall'));
    await tester.pumpAndSettle();

    expect(find.text('No Station ID Found'), findsOneWidget);
  });
}
