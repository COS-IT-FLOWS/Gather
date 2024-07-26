import 'dart:ffi';

class WeatherDataModel {
  final double? precipitationLevel;
  final double? reservoirLevel;
  final double? riverLevel;
  final double? tidalLevel;
  final DateTime dateTime;

  WeatherDataModel({
    required this.dateTime,
    this.precipitationLevel,
    this.reservoirLevel,
    this.riverLevel,
    this.tidalLevel,
  }) : assert(
            (precipitationLevel != null) ||
                (reservoirLevel != null) ||
                (riverLevel != null) ||
                (tidalLevel != null),
            'Level is required');
}
