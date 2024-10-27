import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/datetime_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:gather/screens/about_us_widget.dart';
import 'package:gather/screens/auth_widget.dart';
import 'package:gather/screens/contact_us_widget.dart';
import 'package:gather/screens/event_report_widget.dart';
import 'package:gather/screens/home_page_widget.dart';
import 'package:gather/screens/notification_widget.dart';
import 'package:gather/screens/otp_input_widget.dart';
import 'package:gather/screens/user_profile_widget.dart';
import 'package:gather/routes/app_routes.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart'; // Adjust the import as necessary
import '../mock_classes.dart';

void main() {
  final GlobalConfiguration configuration = GlobalConfiguration();
  late MockAuthProvider mockAuthProvider;
  late MockDatabaseProvider mockDatabaseProvider;
  late MockDateTimeProvider mockDateTimeProvider;
  late MockProfileProvider mockProfileProvider;
  WidgetController.hitTestWarningShouldBeFatal = true;
  setUp(() async {
    mockAuthProvider = MockAuthProvider();
    mockProfileProvider = MockProfileProvider();
    mockDateTimeProvider = MockDateTimeProvider();
    mockDatabaseProvider = MockDatabaseProvider();
    await configuration.loadFromAsset('app_settings');
  });

  testWidgets('AppRoutes returns correct widget for each route',
      (WidgetTester tester) async {
    // Create a MaterialApp to provide the necessary context
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<SignInProvider>(
              create: (_) => mockAuthProvider),
          ChangeNotifierProvider<DatabaseProvider>(
              create: (_) => mockDatabaseProvider),
          ChangeNotifierProvider<DateTimeProvider>(
              create: (_) => mockDateTimeProvider),
          ChangeNotifierProvider<ProfileProvider>(
              create: (_) => mockProfileProvider)
        ],
        builder: (context, child) {
          return MaterialApp(
              initialRoute: '/authentication', routes: AppRoutes.routes());
        }));

    // Test for the authentication route
    expect(find.byType(AuthenticationWidget), findsOneWidget);

    // Test for the OTP screen route
    // await tester.tap(find
    //     .text('Sign Up with Phone')); // Make sure to set a key for navigation
    // await tester.pumpAndSettle();
    // expect(find.byType(OtpInputWidget), findsOneWidget);

    // Test for the home route
    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePageWidget), findsOneWidget);

    // Test for the notifications route
    await tester.tap(find.byIcon(Icons.notifications));
    await tester.pumpAndSettle();
    expect(find.byType(NotificationWidget), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Test for the event report route
    await tester.tap(find.text('Report Hazard'));
    await tester.pumpAndSettle();
    expect(find.byType(EventReportWidget), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    final menuFinder = find.byIcon(Icons.menu);
    await tester.tap(menuFinder);
    await tester.pumpAndSettle();

    final buttonFinder = find.text('Profile');
    expect(buttonFinder, findsOneWidget);

    await tester.ensureVisible(buttonFinder);
    // Test for the profile route
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    expect(find.text('User Profile'), findsOneWidget);

    await tester.pageBack();
    // await tester.pageBack();
    // await tester.tap(menuFinder);
    await tester.pumpAndSettle();
    // Test for the about us route
    await tester.tap(find.text('About Us'));
    await tester.pumpAndSettle();
    expect(find.byType(AboutUsPage), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Test for the contact us route
    await tester.tap(find.text('Contact Us'));
    await tester.pumpAndSettle();
    expect(find.byType(ContactUsPage), findsOneWidget);
  });
}
