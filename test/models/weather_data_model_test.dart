import 'package:flutter_test/flutter_test.dart';
import 'package:gather/models/weather_data_model.dart';
// Adjust the import based on your file structure

void main() {
  group('WeatherDataModel', () {
    test('should create an instance with valid data', () {
      final weatherData = WeatherDataModel(
        dateTime: DateTime.now(),
        precipitationLevel: 10.0,
      );

      expect(weatherData.dateTime, isA<DateTime>());
      expect(weatherData.precipitationLevel, 10.0);
      expect(weatherData.reservoirLevel, isNull);
      expect(weatherData.riverLevel, isNull);
      expect(weatherData.tidalLevel, isNull);
    });

    test('should throw an assertion error if all levels are null', () {
      expect(
        () => WeatherDataModel(
          dateTime: DateTime.now(),
          precipitationLevel: null,
          reservoirLevel: null,
          riverLevel: null,
          tidalLevel: null,
        ),
        throwsAssertionError,
      );
    });

    test('should create an instance with at least one level', () {
      final weatherData1 = WeatherDataModel(
        dateTime: DateTime.now(),
        reservoirLevel: 5.0,
      );

      final weatherData2 = WeatherDataModel(
        dateTime: DateTime.now(),
        riverLevel: 3.0,
      );

      final weatherData3 = WeatherDataModel(
        dateTime: DateTime.now(),
        tidalLevel: 2.0,
      );

      expect(weatherData1.reservoirLevel, 5.0);
      expect(weatherData2.riverLevel, 3.0);
      expect(weatherData3.tidalLevel, 2.0);
    });
  });
}
