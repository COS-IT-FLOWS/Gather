import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gather/components/confirmation_dialog_widget.dart'; // Adjust the import based on your file structure

void main() {
  testWidgets(
      'showConfirmationDialog displays the correct question and buttons',
      (WidgetTester tester) async {
    // Arrange
    String question = 'Are you sure you want to proceed?';
    String cancelButtonText = 'Cancel';
    String confirmButtonText = 'Confirm';
    bool isConfirmed = false;
    bool isCanceled = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              // Call the dialog here, passing the context
              return ElevatedButton(
                onPressed: () {
                  showConfirmationDialog(
                    context: context,
                    question: question,
                    cancelButtonText: cancelButtonText,
                    confirmButtonText: confirmButtonText,
                    onCancel: () {
                      isCanceled = true;
                    },
                    onConfirm: () {
                      isConfirmed = true;
                    },
                  );
                },
                child: Text('Show Dialog'),
              );
              // Return an empty container
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Show Dialog'));
    // Rebuild the widget tree to show the dialog
    await tester.pumpAndSettle();

    // Assert
    expect(find.text(question), findsOneWidget);
    expect(find.text(cancelButtonText), findsOneWidget);
    expect(find.text(confirmButtonText), findsOneWidget);
  });

  testWidgets('showConfirmationDialog calls onCancel when Cancel is pressed',
      (WidgetTester tester) async {
    // Arrange
    String question = 'Are you sure you want to proceed?';
    String cancelButtonText = 'Cancel';
    String confirmButtonText = 'Confirm';
    bool isCanceled = false;
    bool isConfirmed = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              // Call the dialog here, passing the context
              return ElevatedButton(
                onPressed: () {
                  showConfirmationDialog(
                    context: context,
                    question: question,
                    cancelButtonText: cancelButtonText,
                    confirmButtonText: confirmButtonText,
                    onCancel: () {
                      isCanceled = true;
                    },
                    onConfirm: () {
                      isConfirmed = true;
                    },
                  );
                },
                child: Text('Show Dialog'),
              );
              // Return an empty container
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Show Dialog'));
    // Rebuild the widget tree to show the dialog
    await tester.pumpAndSettle();

    // Press the Cancel button
    await tester.tap(find.text(cancelButtonText));
    await tester.pumpAndSettle();

    // Assert
    expect(isCanceled, isTrue);
  });

  testWidgets('showConfirmationDialog calls onConfirm when Confirm is pressed',
      (WidgetTester tester) async {
    // Arrange
    String question = 'Are you sure you want to proceed?';
    String cancelButtonText = 'Cancel';
    String confirmButtonText = 'Confirm';
    bool isConfirmed = false;
    bool isCanceled = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              // Call the dialog here, passing the context
              return ElevatedButton(
                onPressed: () {
                  showConfirmationDialog(
                    context: context,
                    question: question,
                    cancelButtonText: cancelButtonText,
                    confirmButtonText: confirmButtonText,
                    onCancel: () {
                      isCanceled = true;
                    },
                    onConfirm: () {
                      isConfirmed = true;
                    },
                  );
                },
                child: Text('Show Dialog'),
              );
              // Return an empty container
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Show Dialog'));
    // Rebuild the widget tree to show the dialog
    await tester.pumpAndSettle();

    // Rebuild the widget tree to show the dialog
    await tester.pumpAndSettle();

    // Press the Confirm button
    await tester.tap(find.text(confirmButtonText));
    await tester.pumpAndSettle();

    // Assert
    expect(isConfirmed, isTrue);
  });
}
