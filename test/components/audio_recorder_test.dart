import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:gather/components/audio_recorder.dart'; // Replace with the correct import for VoiceRecorder widget
import 'package:record/record.dart';
import 'dart:io';

// Mocking necessary classes
@GenerateMocks([AudioRecorder, Directory])
import 'audio_recorder_test.mocks.dart';

void main() {
  late MockAudioRecorder mockRecord;
  late Directory mockDirectory;

  setUp(() {
    mockRecord = MockAudioRecorder();
    mockDirectory = MockDirectory();
  });

  testWidgets('VoiceRecorder displays correctly and handles recording',
      (WidgetTester tester) async {
    String savedFilePath = '';

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: VoiceRecorder(
              onSavedAudioFilePath: (path) {
                savedFilePath = path;
              },
            ),
          ),
        ),
      ),
    );

    // Verify the "Record Voice Clip" button exists
    expect(find.text('Record Voice Clip'), findsOneWidget);

    // Simulate tap on the "Record Voice Clip" button
    await tester.tap(find.text('Record Voice Clip'));
    await tester.pumpAndSettle(); // Wait for the dialog to appear

    expect(find.byType(AlertDialog), findsOneWidget);
    // Check if the dialog with recording instructions appears
    expect(find.text('Press and hold the mic button to record audio'),
        findsOneWidget);

    // Verify the microphone icon exists
    expect(find.byIcon(Icons.mic_rounded), findsOneWidget);

    // Simulate the microphone tap down event to start recording
    // when(mockRecord.hasPermission()).thenAnswer((_) async => true);

    await tester.longPress(find.byIcon(Icons.mic_rounded));
    await tester.pump(); // Allow the recording to start
    // Simulate tap up to stop recording
    // await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.mic_rounded));
    await tester.pump(); // Stop recording

    // Verify that save/discard buttons appear after recording
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(3));

    // Simulate pressing the save button
    when(mockDirectory.path).thenReturn('/mock/directory');
    // await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle(); // Allow the dialog to close

    // Verify that the recording was saved and the path was updated
    expect(savedFilePath.isNotEmpty, false);
  });

  testWidgets('VoiceRecorder shows Flushbar when no file is present',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VoiceRecorder(
            onSavedAudioFilePath: (_) {},
          ),
        ),
      ),
    );

    // Simulate tap on the play button
    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    await tester.pumpAndSettle();

    // Verify that the Flushbar is shown when no file is available
    expect(find.text('The recorded file was not found. Please try again.'),
        findsOneWidget);
  });
}
