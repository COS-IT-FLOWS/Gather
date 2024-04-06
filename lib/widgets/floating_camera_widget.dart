import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingCameraWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(icon: Icons.camera, children: [
      SpeedDialChild(child: Icon(Icons.camera), label: 'Camera'),
      SpeedDialChild(child: Icon(Icons.browse_gallery), label: 'Gallery'),
    ]);
  }
}
