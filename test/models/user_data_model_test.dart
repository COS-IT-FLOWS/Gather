import 'package:test/test.dart';
import 'package:gather/models/user_data_model.dart'; // Adjust the import as necessary

void main() {
  group('UserDataModel', () {
    test('should create an instance with required fields', () {
      // Arrange
      final userData = UserDataModel(
        firstName: 'John',
        lastName: 'Doe',
      );

      // Act & Assert
      expect(userData.firstName, 'John');
      expect(userData.lastName, 'Doe');
      expect(userData.phoneNumber, isNull);
      expect(userData.emailAddress, isNull);
      expect(userData.occupation, isNull);
      expect(userData.userAge, isNull);
      expect(userData.gender, isNull);
      expect(userData.stationIds, isNull);
    });

    test('should create an instance with all fields', () {
      // Arrange
      final userData = UserDataModel(
        firstName: 'Jane',
        lastName: 'Doe',
        phoneNumber: '1234567890',
        emailAddress: 'jane.doe@example.com',
        occupation: 'Engineer',
        userAge: 30,
        gender: 'Female',
        stationIds: ['station1', 'station2'],
      );

      // Act & Assert
      expect(userData.firstName, 'Jane');
      expect(userData.lastName, 'Doe');
      expect(userData.phoneNumber, '1234567890');
      expect(userData.emailAddress, 'jane.doe@example.com');
      expect(userData.occupation, 'Engineer');
      expect(userData.userAge, 30);
      expect(userData.gender, 'Female');
      expect(userData.stationIds, ['station1', 'station2']);
    });
  });
}
