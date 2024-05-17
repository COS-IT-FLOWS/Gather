import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gather/components/appbar_original_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class EventReportWidget extends StatefulWidget {
  @override
  _EventReportWidgetState createState() => _EventReportWidgetState();
}

class _EventReportWidgetState extends State<EventReportWidget> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _audioPath;
  // final _recorder = Recorder();,
  bool _isRecording = false;

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Future<void> _recordAudio() async {
  //   if (!_isRecording) {
  //     await _recorder.start(path: _getAudioPath());
  //     setState(() {
  //       _isRecording = true;
  //     });
  //   } else {
  //     final path = await _recorder.stop();
  //     setState(() {
  //       _audioPath = path;
  //       _isRecording = false;
  //     });
  //   }
  // }

  // String _getAudioPath() {
  //   final Directory directory = Directory(
  //       (await getApplicationDocumentsDirectory()).path + '/audioRecorder');
  //   if (!directory.existsSync()) {
  //     directory.createSync();
  //   }
  //   return directory.path + '/audio.aac';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Report Event'),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    'Report extreme weather phenomena such as floods, flash floods, landslides, heatwaves, etc.'),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _getImage,
                        child: Text('Upload Photo'),
                      ),
                      ElevatedButton(
                        onPressed: _takePhoto,
                        child: Text('Take Photo'),
                      ),
                    ]),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Write content here',
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: _recordAudio,
                //   child: _isRecording
                //       ? Text('Stop Recording')
                //       : Text('Start Recording'),
                // ),
                // if (_image != null) Image.file(_image),
                // if (_audioPath != null) Text(_audioPath),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: FFButtonWidget(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Event Report Completed"),
                ));
                Navigator.of(context).pop();
              },
              text: 'Submit',
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width * 0.6,
                height: 40,
                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleMedium,
                elevation: 3,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // _recorder.dispose();
    super.dispose();
  }
}
