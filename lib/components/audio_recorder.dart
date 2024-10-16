import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';

class VoiceRecorder extends StatefulWidget {
  final Function(String) onSavedAudioFilePath;
  VoiceRecorder({required this.onSavedAudioFilePath});

  @override
  _VoiceRecorderState createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> {
  final record = AudioRecorder();
  bool _isRecording = false;
  bool _showSaveDiscardButtons = false;
  String _recordedFilePath = '';
  String savedAudioFilePath = '';
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(0, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                      color: FlutterFlowTheme.of(context).secondary))),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                'Press and hold the mic button to record audio'),
                            GestureDetector(
                                onTapDown: (details) async {
                                  if (await record.hasPermission()) {
                                    setState(() {
                                      _isRecording = true;
                                    });
                                    final directory =
                                        await getApplicationDocumentsDirectory();
                                    _recordedFilePath =
                                        '${directory.path}/tempFile.m4a';
                                    await record.start(const RecordConfig(),
                                        path: _recordedFilePath);
                                  }
                                },
                                onTapUp: (details) async {
                                  if (_isRecording) {
                                    final path = await record.stop();
                                    setState(() {
                                      _isRecording = false;
                                      _showSaveDiscardButtons = true;
                                    });
                                  }
                                },
                                onTapCancel: () async {
                                  if (_isRecording) {
                                    final path = await record.stop();
                                    setState(() {
                                      _isRecording = false;
                                      _showSaveDiscardButtons = true;
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _isRecording
                                          ? FlutterFlowTheme.of(context)
                                              .secondary
                                          : Colors.transparent,
                                      width: 30.0,
                                    ),
                                  ),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(0, 50),
                                          shape: CircleBorder()),
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.mic_rounded,
                                        size: 100,
                                      )),
                                )),
                            if (_showSaveDiscardButtons) // Conditionally display buttons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Handle discard action
                                      if (await File(_recordedFilePath)
                                          .exists()) {
                                        await File(_recordedFilePath).delete();
                                        setState(() {
                                          savedAudioFilePath = '';
                                        });
                                      }
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Icon(Icons.close),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Handle save action
                                      DateTime now = DateTime.now();
                                      final directory =
                                          await getApplicationDocumentsDirectory();
                                      String saveFilePath =
                                          '${directory.path}/${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}.m4a';
                                      if (await File(_recordedFilePath)
                                          .exists()) {
                                        await File(_recordedFilePath)
                                            .copy(saveFilePath);
                                        await File(_recordedFilePath).delete();
                                        setState(() {
                                          savedAudioFilePath = saveFilePath;
                                        });
                                        widget.onSavedAudioFilePath(
                                            savedAudioFilePath);
                                      }
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Icon(Icons.check),
                                  ),
                                ],
                              ),
                          ],
                        ));
                  });
                });
          },
          child: Text(
              style: TextStyle(fontWeight: FontWeight.bold),
              'Record Voice Clip'),
        )),
        SizedBox(width: 15),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(0, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                        color: FlutterFlowTheme.of(context).secondary))),
            onPressed: _playRecording,
            child: Icon(Icons.play_arrow_rounded)),
      ],
    );
  }

  Future<void> _playRecording() async {
    if (savedAudioFilePath.isNotEmpty) {
      await _audioPlayer.play(DeviceFileSource(savedAudioFilePath));
    } else {
      Flushbar(
        message: 'The recorded file was not found. Please try again.',
        duration: Duration(seconds: 3), // Show the dialog for 3 seconds
      ).show(context);
    }
  }

  @override
  void dispose() {
    record.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}
