import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:image_picker/image_picker.dart';

class FloatingCameraWidget extends StatefulWidget {
  @override
  FloatingCameraWidgetState createState() => FloatingCameraWidgetState();
}

class FloatingCameraWidgetState extends State<FloatingCameraWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/eventreport');
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: FlutterFlowTheme.of(context).secondary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: FlutterFlowTheme.of(context).secondary))),
      // style: ButtonStyle(

      //     backgroundColor: MaterialStateProperty.all<Color>(
      //         FlutterFlowTheme.of(context).secondary)),
      child: Text(
        'Report Hazard',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: FlutterFlowTheme.of(context).primary,
        ),
      ),
    );
  }
}
