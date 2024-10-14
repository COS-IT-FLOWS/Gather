import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gather/components/appbar_widget.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:record/record.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:gather/components/audio_recorder.dart';
import 'package:gather/components/hazard_type_question.dart';

class EventReportWidget extends StatefulWidget {
  @override
  _EventReportWidgetState createState() => _EventReportWidgetState();
}

class _EventReportWidgetState extends State<EventReportWidget> {
  final ImagePicker _picker = ImagePicker();

  List<File>? _pickedImages = [];
  String? _audioPath;
  // final _recorder = AudioRecorder();
  bool _isRecording = false;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    setState(() {
      if (pickedFiles != null) {
        _pickedImages = pickedFiles.map((file) => File(file.path)).toList();
      } else {
        _pickedImages = [];
      }
    });
  }

  // Future<void> takePhoto() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Report Hazard'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
                style: TextStyle(fontSize: 20),
                'Report extreme weather phenomena such as floods, flash floods, landslides, heatwaves, etc.'),
            SizedBox(height: 30),
            HazardTypeQuestion(),
            SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).secondary))),
                      onPressed: () {
                        getImage();
                      },
                      child: Center(
                          child: Text(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              'Upload Photo'))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).secondary))),
                      // onPressed: takePhoto,
                      onPressed: () {},
                      child: Center(
                          child: Text(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              'Open Camera'))),
                ]),
            SizedBox(height: 15),
            Container(
              constraints: BoxConstraints(minHeight: 100),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: FlutterFlowTheme.of(context).primary, width: 2),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Wrap(children: [
                  _pickedImages != null && _pickedImages!.isNotEmpty
                      ? Column(
                          children: [
                            GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                                shrinkWrap: true,
                                children: _pickedImages!.map((image) {
                                  return Draggable(
                                    feedback: Container(
                                      width:
                                          100, // set a fixed width for each image
                                      height:
                                          100, // set a fixed height for each image
                                      child:
                                          Image.file(image, fit: BoxFit.cover),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Container(
                                        // width:
                                        //     100, // set a fixed width for each image
                                        // height:
                                        //     100, // set a fixed height for each image
                                        child: Image.file(image,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    onDragEnd: (details) {
                                      // Check if the image was dragged out of the screen

                                      if (details.offset.dx >
                                              MediaQuery.of(context)
                                                  .size
                                                  .width ||
                                          details.offset.dx > 0 ||
                                          details.offset.dy >
                                              MediaQuery.of(context)
                                                  .size
                                                  .height ||
                                          details.offset.dy > 0) {
                                        // Remove the image from the list

                                        setState(() {
                                          _pickedImages!.remove(image);
                                        });
                                      }
                                    },
                                  );
                                }).toList()),
                            Text('Drag image out to remove')
                          ],
                        )
                      : Text('No images selected')
                ]),
              ),
            ),
            SizedBox(height: 30),
            VoiceRecorder(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Short description of hazard',
                ),
              ),
            ),
            SizedBox(height: 30),
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
      ),
    );
  }

  @override
  void dispose() {
    // _recorder.dispose();
    super.dispose();
  }
}
