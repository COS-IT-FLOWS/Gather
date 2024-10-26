import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:gather/components/hazard_type_question.dart'; // Adjust the import based on your file structure
import 'package:global_configuration/global_configuration.dart';

void main() {
  late GlobalConfiguration configuration;
  // Mock data for the global configuration
  const mockHazardTypes = {
    'QUESTION': 'What type of hazard is this?',
    'OPTIONS': [
      {'text': 'Fire', 'value': 'fire'},
      {'text': 'Flood', 'value': 'flood'},
      {'text': 'Earthquake', 'value': 'earthquake'},
    ],
  };

  setUpAll(() {
    // Set up the global configuration before all tests
    configuration =
        GlobalConfiguration().loadFromMap({'HAZARD_TYPES': mockHazardTypes});
  });

  testWidgets('displays the question and options', (WidgetTester tester) async {
    String selectedOption = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HazardTypeQuestion(
            onOptionSelected: (value) {
              selectedOption = value;
            },
            config: configuration,
          ),
        ),
      ),
    );

    // Verify that the question is displayed
    expect(find.text('What type of hazard is this?'), findsOneWidget);

    // Verify that the options are displayed
    expect(find.text('Fire'), findsOneWidget);
    expect(find.text('Flood'), findsOneWidget);
    expect(find.text('Earthquake'), findsOneWidget);
  });

  testWidgets('selecting an option calls onOptionSelected',
      (WidgetTester tester) async {
    String selectedOption = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HazardTypeQuestion(
              onOptionSelected: (value) {
                selectedOption = value;
              },
              config: configuration),
        ),
      ),
    );

    // Tap on the 'Flood' option
    await tester.tap(find.text('Flood'));
    await tester.pumpAndSettle();

    // Verify that the onOptionSelected callback was called with the correct value
    expect(selectedOption, 'flood');
  });
}
