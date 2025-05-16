import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/appbar_widget.dart'; // Replace with the actual file path
// import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('appBarWidget test with context', (WidgetTester tester) async {
    // Create a MaterialApp with a Scaffold
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Body')),
      ),
    ));

    // Get the context of the Scaffold after it has been built
    final scaffoldContext = tester.element(find.byType(Scaffold));

    // Now pass the context to the appBarWidget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: appBarWidget(scaffoldContext, 'Test Title'),
        body: Center(child: Text('Body')),
      ),
    ));

    // Check if the notification button is displayed
    expect(find.byIcon(Icons.notifications), findsOneWidget);

    // Verify if the AppBar is present
    expect(find.byType(AppBar), findsOneWidget);

    // Verify the title of the AppBar
    expect(find.text('Test Title'), findsOneWidget);

    expect(find.byIcon(Icons.notifications), findsOneWidget);

    // Simulate tapping the notification icon to navigate to the notifications route

    await tester.tap(find.byIcon(Icons.notifications));

    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Now verify that the notification button is hidden on the notifications route

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: appBarWidget(scaffoldContext, 'Test Title'),
        body: Center(child: Text('Body')),
      ),
      routes: {
        '/notifications': (context) =>
            Scaffold(body: Center(child: Text('Notifications'))),
      },
    ));

    // Verify that the notification button is hidden on the notifications route

    expect(find.byIcon(Icons.notifications), findsNothing);
  });
}
