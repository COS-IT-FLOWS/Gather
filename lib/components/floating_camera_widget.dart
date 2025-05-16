import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gather/themes/app_theme.dart';

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
          backgroundColor: AppTheme.secondaryColor(context),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: AppTheme.secondaryColor(context)))),
      child: Text(
        'Report Hazard',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryBackground(context),
        ),
      ),
    );
  }
}
