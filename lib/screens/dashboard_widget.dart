import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final styleUrl =
      "https://tiles.stadiamaps.com/styles/alidade_smooth_dark.json";

  final apiKey = "f6558934-8d10-4a29-b789-2c108720ceff";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaplibreMap(
        styleString: "$styleUrl?api_key=$apiKey",
        myLocationEnabled: true,
        initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),
        trackCameraPosition: true,
      ),
    );
  }
}
