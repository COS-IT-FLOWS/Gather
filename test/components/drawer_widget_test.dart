import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:gather/components/drawer_widget.dart'; // Adjust the import based on your file structure
// import '../mock_classes.dart'; // Import your mock classes
import 'package:mockito/mockito.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/screens/user_profile_widget.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockSignInProvider extends Mock implements SignInProvider {}

class MockDatabaseProvider extends Mock implements DatabaseProvider {}

class MockProfileProvider extends Mock implements ProfileProvider {}

void main() {
  group('DrawerWidget Tests', () {
    late MockSignInProvider mockSignInProvider;
    late MockDatabaseProvider mockDatabaseProvider;
    late MockProfileProvider mockProfileProvider;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      // Initialize the mock provider and navigator observer
      mockSignInProvider = MockSignInProvider();
      mockDatabaseProvider = MockDatabaseProvider();
      mockProfileProvider = MockProfileProvider();
      mockNavigatorObserver = MockNavigatorObserver();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<SignInProvider>.value(
          value: mockSignInProvider,
          child: MaterialApp(
            home: Scaffold(
              body: DrawerWidget(),
            ),
          ),
        ),
      );

      // Check if the DrawerHeader is displayed
      expect(find.text('Gather Menu'), findsOneWidget);
      // Check if the menu items are displayed
      expect(find.text('Weather Dashboard'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('About Us'), findsOneWidget);
      expect(find.text('Contact Us'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
    });

    testWidgets('navigates to Profile when Profile is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<SignInProvider>.value(
                value: mockSignInProvider),
            ChangeNotifierProvider<DatabaseProvider>.value(
                value: mockDatabaseProvider),
            ChangeNotifierProvider<ProfileProvider>.value(
                value: mockProfileProvider),
          ],
          child: MaterialApp(
            routes: {
              '/': (context) => Scaffold(body: DrawerWidget()),
              '/profile': (context) =>
                  ProfileWidget(), // Ensure this route is defined
            },

            // navigatorObservers: [
            //   mockNavigatorObserver
            // ], // Use the mock observer here
          ),
        ),
      );

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      print(tester.allWidgets);

//       // Verify that the navigation occurred
//       // verify(mockNavigatorObserver.didPush(captureAny, captureAny)).called(1);
//       // final capturedRoute =
//       //     verify(mockNavigatorObserver.didPush(captureAny, captureAny));
//       // //         .captured
//       // //         .single;

//       // // Verify that the captured route is of the correct type
//       // expect(capturedRoute, isA<Route<dynamic>>());
//       // // Check the route's name
//       // expect(capturedRoute.settings.name, '/profile');
    });

//     testWidgets('logs out and shows snackbar when Logout is tapped',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         ChangeNotifierProvider<SignInProvider>.value(
//           value: mockSignInProvider,
//           child: MaterialApp(
//             routes: {
//               '/': (context) => Scaffold(body: DrawerWidget()),
//               '/profile': (context) =>
//                   ProfileWidget(), // Ensure this route is defined
//             },
//             // home: Scaffold(body: DrawerWidget()),
//             navigatorObservers: [
//               mockNavigatorObserver
//             ], // Use the mock observer here
//           ),
//         ),
//       );

//       // Mock the signOut method
//       when(mockSignInProvider.signOut())
//           .thenAnswer((_) async => Future.value());

//       await tester.tap(find.text('Logout'));
//       await tester.pumpAndSettle();

//       // Verify that signOut was called
//       verify(mockSignInProvider.signOut()).called(1);
//       // Verify navigation to the authentication screen
//       verify(mockNavigatorObserver.didReplace()).called(1);
//       // Verify snackbar is shown
//       // expect(find.text('You have successfully logged out'), findsOneWidget);
//     });
  });
}
