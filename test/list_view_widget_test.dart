import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/data_text_form_widget.dart';
import 'package:gather/models/list_view_model.dart';
import 'package:gather/screens/list_view_widget.dart';
import 'package:mockito/mockito.dart';

class MockListViewModel extends Mock implements ListViewModel {}

void main() {
  testWidgets(
      'ListViewWidget renders ListView with correct number of ListTiles',
      (WidgetTester tester) async {
    final mockListViewModel = MockListViewModel();

    await tester.pumpWidget(MaterialApp(
      home: ListViewWidget(model: mockListViewModel),
    ));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(5));
  });

  testWidgets(
      'ListViewWidget renders DataTextFormWidget when ListTile is tapped',
      (WidgetTester tester) async {
    final mockListViewModel = MockListViewModel();
    when(mockListViewModel.unfocusNode).thenReturn(FocusNode());

    await tester.pumpWidget(MaterialApp(
      home: ListViewWidget(model: mockListViewModel),
    ));

    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    expect(find.byType(DataTextFormWidget), findsOneWidget);
  });
}
