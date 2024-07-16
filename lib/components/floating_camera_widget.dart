import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:image_picker/image_picker.dart';

class FloatingCameraWidget extends StatefulWidget {
  @override
  FloatingCameraWidgetState createState() => FloatingCameraWidgetState();
}

class FloatingCameraWidgetState extends State<FloatingCameraWidget> {
  File? _image;

  Future<void> openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/eventreport');
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              FlutterFlowTheme.of(context).tertiary)),
      child: Text(
        'Report Hazard Event',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    // return SpeedDial(
    //     icon: Icons.camera,
    //     backgroundColor: FlutterFlowTheme.of(context).tertiary,
    //     children: [
    //       SpeedDialChild(
    //           shape: CircleBorder(),
    //           backgroundColor: FlutterFlowTheme.of(context).tertiary,
    //           child: Icon(Icons.camera_alt),
    //           label: 'Camera',
    //           onTap: openCamera),
    //       SpeedDialChild(
    //           shape: CircleBorder(),
    //           backgroundColor: FlutterFlowTheme.of(context).tertiary,
    //           child: Icon(Icons.photo),
    //           label: 'Gallery',
    //           onTap: openGallery),
    //     ]);
  }
}
