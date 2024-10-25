import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/routes/app_routes.dart'; // Adjust the import as necessary
import 'package:gather/providers/auth_provider.dart'; // Adjust the import as necessary
// import '../mock_classes.dart'; // Adjust the import as necessary
import 'package:provider/provider.dart'; // Ensure you import provider
import 'package:mockito/mockito.dart';

class MockSignInProvider extends Mock implements SignInProvider {}

void main() {
  testWidgets('AppRoutes returns correct widgets for each route',
      (WidgetTester tester) async {
    // Create an instance of the mock sign-in provider
    final mockSignInProvider = MockSignInProvider();

    // Test each route
    final routes = AppRoutes.routes();

    for (var route in routes.keys) {
      // Build the MaterialApp with the specific route and the mock provider
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: route,
          routes: routes,
          builder: (context, child) {
            return ChangeNotifierProvider<SignInProvider>.value(
              value: mockSignInProvider,
              child: child!,
            );
          },
        ),
      );

      // Verify that the correct widget is displayed for the route
      expect(find.byType(Route), findsOneWidget);
    }
  });
}
