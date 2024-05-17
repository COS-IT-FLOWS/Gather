import 'package:flutter/material.dart';
import 'package:gather/components/appbar_original_widget.dart';
import 'package:gather/components/floating_camera_widget.dart';

class NotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Notifications'),
      body: Center(
        child: Text('You have 0 notifications'),
      ),
      floatingActionButton: FloatingCameraWidget(),
    );
  }
}
