import 'package:flutter/material.dart';
import 'package:gather/components/appbar_widget.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, 'About Us'),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    width: 150,
                    height: 150,
                    "assets/logos/gather_splash.png",
                  ),
                  Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                      'Gather is an open source application (under MIT License) to enter data on various weather conditions such as rainfall, river level, groundwater level and tidal levels for the community, as part of the Gather weather data network, built and maintained by EQUINOCT Community Sourced Modelling Solutions.'),
                  Image.asset("assets/logos/equinoct_logo.png")
                ])));
  }
}
