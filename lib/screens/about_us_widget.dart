import 'package:flutter/material.dart';
import 'package:gather/components/appbar_widget.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, 'About Us'),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Text(
                  'Gather is an application to enter data on various weather conditions such as rainfall, river level, groundwater level and tidal levels for the community, as part of the Gather weather data network, built and maintained by EQUINOCT Community Sourced Modelling Solutions'),
              Image.asset("assets/logos/equinoct_logo.png")
            ])));
  }
}
