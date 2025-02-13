import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:gather/screens/contact_us_widget.dart'; // Adjust the import based on your file structure

void main() {
  // Mock data for the global configuration
  const mockContactDetails = {
    'WHATSAPP': '+1234567890',
    'PHONE': '+0987654321',
    'EMAIL': 'contact@example.com',
  };

  setUpAll(() {
    // Set up the global configuration before all tests
    GlobalConfiguration().loadFromMap({'CONTACT_US': mockContactDetails});
  });

  testWidgets('displays loading indicator while fetching data',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContactUsPage(),
      ),
    );

    // Verify that the loading indicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays error message when there is an error',
      (WidgetTester tester) async {
    // Simulate an error by overriding the _loadContactDetails method
    // final contactUsPage = ContactUsPage();
    // var originalLoadMethod = contactUsPage.loadContactDetails;

    // originalLoadMethod = () async {
    //   throw Exception('Failed to load contact details');
    // };

    await tester.pumpWidget(
      MaterialApp(
        home: ContactUsPage(
          loadContactDetails: () async {
            throw Exception('Failed to load contact details');
          },
        ),
      ),
    );

    // Wait for the FutureBuilder to complete
    await tester.pumpAndSettle();

    // Verify that the error message is displayed
    expect(find.text('Error: Exception: Failed to load contact details'),
        findsOneWidget);
  });

  testWidgets('displays contact details when data is loaded',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContactUsPage(
          loadContactDetails: () async => mockContactDetails,
        ),
      ),
    );

    // Wait for the FutureBuilder to complete
    await tester.pumpAndSettle();

    // Verify that the contact details are displayed
    expect(find.text('+1234567890'), findsOneWidget);
    expect(find.text('+0987654321'), findsOneWidget);
    expect(find.text('contact@example.com'), findsOneWidget);
  });

  testWidgets('displays no data available message when no data is present',
      (WidgetTester tester) async {
    // Simulate no data by overriding the _loadContactDetails method
    // final contactUsPage = ContactUsPage();
    // final originalLoadMethod = contactUsPage.loadContactDetails;

    // contactUsPage.loadContactDetails = () async {
    //   return {}; // Return an empty map
    // };

    await tester.pumpWidget(
      MaterialApp(
        home: ContactUsPage(
            loadContactDetails: () async =>
                {"PHONE": "", "WHATSAPP": "", "EMAIL": ""}),
      ),
    );

    // Wait for the FutureBuilder to complete
    await tester.pumpAndSettle();
    print(tester.widget(find.byType(String)));

    // Verify that the no data message is displayed
    expect(find.text('data'), findsOneWidget);
  });
}
