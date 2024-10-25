import 'package:flutter_test/flutter_test.dart';
import 'package:gather/models/hazard_data_model.dart'; // Adjust the import as necessary

void main() {
  group('HazardDataModel', () {
    test(
        'should initialize with required hazardType and optional hazardDescription',
        () {
      // Arrange
      const hazardType = 'Chemical Spill';
      const hazardDescription = 'A large chemical spill occurred in the lab.';

      // Act
      final hazardData = HazardDataModel(
          hazardType: hazardType, hazardDescription: hazardDescription);

      // Assert
      expect(hazardData.hazardType, equals(hazardType));
      expect(hazardData.hazardDescription, equals(hazardDescription));
    });

    test('should initialize with null hazardDescription if not provided', () {
      // Arrange
      const hazardType = 'Fire';

      // Act
      final hazardData = HazardDataModel(hazardType: hazardType);

      // Assert
      expect(hazardData.hazardType, equals(hazardType));
      expect(hazardData.hazardDescription, isNull);
    });
  });
}
