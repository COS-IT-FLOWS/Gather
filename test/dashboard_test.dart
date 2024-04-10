import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:gather/screens/dashboard_widget.dart';

void main() {
  testWidgets(
      'DashboardWidget renders MaplibreMap with correct style and myLocationEnabled',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardWidget()));

    expect(find.byType(MaplibreMap), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is MaplibreMap &&
            widget.styleString ==
                "https://tiles.stadiamaps.com/styles/alidade_smooth_dark.json?api_key=f6558934-8d10-4a29-b789-2c108720ceff"),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MaplibreMap && widget.myLocationEnabled),
        findsOneWidget);
  });
}
