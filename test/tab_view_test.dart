import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/floating_camera_widget.dart';
import 'package:gather/screens/list_view_widget.dart';
import 'package:gather/screens/dashboard_widget.dart';
import 'package:gather/screens/notification_widget.dart';
import 'package:gather/screens/tab_view_widget.dart';

void main() {
  testWidgets(
      'TabViewWidget renders DefaultTabController with correct number of tabs',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TabViewWidget(),
    ));

    expect(find.byType(DefaultTabController), findsOneWidget);
    expect(find.byType(TabBar), findsOneWidget);
    expect(find.byType(TabBarView), findsOneWidget);
    expect(find.byType(Tab), findsNWidgets(3));
  });

  testWidgets('TabViewWidget renders correct widget for each tab',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TabViewWidget(),
    ));

    await tester.tap(find.byIcon(Icons.numbers));
    await tester.pumpAndSettle();
    expect(find.byType(ListViewWidget), findsOneWidget);

    await tester.tap(find.byIcon(Icons.dashboard));
    await tester.pumpAndSettle();
    expect(find.byType(DashboardWidget), findsOneWidget);

    await tester.tap(find.byIcon(Icons.notifications));
    await tester.pumpAndSettle();
    expect(find.byType(NotificationWidget), findsOneWidget);
  });

  testWidgets('TabViewWidget renders FloatingCameraWidget',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TabViewWidget(),
    ));

    expect(find.byType(FloatingCameraWidget), findsOneWidget);
  });
}
