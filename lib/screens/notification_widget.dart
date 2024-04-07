import 'package:flutter/material.dart';
import 'package:gather/components/appbar_widget.dart';

class NotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Container(
        child: Text('You have 0 notifications'),
      ),
    );
  }
}
