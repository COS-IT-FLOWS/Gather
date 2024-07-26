import 'package:flutter/material.dart';
import 'package:gather/components/appbar_widget.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, 'About Us'),
        body: Center(child: Text('Random rambling...')));
  }
}
