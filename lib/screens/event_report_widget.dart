import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gather/components/appbar_widget.dart';
import 'package:gather/models/hazard_data_model.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:global_configuration/global_configuration.dart';

import 'package:gather/components/audio_recorder.dart';
import 'package:gather/components/hazard_type_question.dart';
import 'package:provider/provider.dart';
import 'package:gather/themes/app_theme.dart';

class EventReportWidget extends StatefulWidget {
  final ImagePicker picker;
  final GlobalConfiguration config;

  EventReportWidget({required this.picker, required this.config});

  @override
  _EventReportWidgetState createState() => _EventReportWidgetState();
}

class _EventReportWidgetState extends State<EventReportWidget> {
  List<File>? _pickedImages = [];
  String? _savedAudioFilePath = '';

  void _updateSavedAudioFilePath(String filePath) {
    setState(() {
      _savedAudioFilePath = filePath;
    });
  }

  Future<void> getImage() async {
    // final Ipicker = ImagePicker();
    final pickedFiles = await widget.picker.pickMultiImage();
    setState(() {
      if (pickedFiles != null) {
        _pickedImages = pickedFiles.map((file) => File(file.path)).toList();
      } else {
        _pickedImages = [];
      }
    });
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await widget.picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedImages!.add(File(pickedFile.path));
      });
    }
  }

  @override
  HazardDataModel hazardDataWriteModel = HazardDataModel(hazardType: '');
  final hazardDescriptionController = TextEditingController();
  Widget build(BuildContext context) {
    DatabaseProvider databaseProvider = context.read<DatabaseProvider>();
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
            HazardTypeQuestion(
              onOptionSelected: (selectedOption) {
                hazardDataWriteModel.hazardType = selectedOption;
              },
              config: widget.config,
            ),
            SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                      key: Key('photo-upload'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AppTheme.secondaryColor(context)))),
                      onPressed: () {
                        getImage();
                      },
                      child: Center(
                          child: Text(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              'Upload Photo'))),
                  ElevatedButton(
                      key: Key('camera-upload'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: AppTheme.secondaryColor(context)))),
                      // onPressed: takePhoto,
                      onPressed: () {
                        takePhoto();
                      },
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
                      color: AppTheme.primaryColor(context), width: 2),
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
            VoiceRecorder(onSavedAudioFilePath: _updateSavedAudioFilePath),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: hazardDescriptionController,
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
              child: ElevatedButton(
                key: Key('submit-report'),
                onPressed: () async {
                  hazardDataWriteModel.hazardDescription =
                      hazardDescriptionController.text;
                  final hazardId = await databaseProvider
                      .insertHazardEventDataAndGetHazardId(
                          hazardDataWriteModel);
                  // final hazardId = await databaseProvider.readHazardId();
                  bool ifFilesUploaded = await databaseProvider.uploadFiles(
                      hazardId, _pickedImages, _savedAudioFilePath);
                  if (ifFilesUploaded == true) {
                    await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Data Submitted Successfully'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Unable to Submit Data'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Retry'),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor(context),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  padding: EdgeInsets.zero,
                  textStyle: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: Text('Submit'),
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
