import 'package:gather/models/user_data_model.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mockito/mockito.dart';
import 'package:gather/providers/datetime_provider.dart'; // Adjust imports
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:flutter/material.dart';

class MockDateTimeProvider extends Mock implements DateTimeProvider {
  @override
  DateTime get initialDate => DateTime(2024, 5, 20);

  @override
  TimeOfDay get initialTime => TimeOfDay(hour: 8, minute: 30);

  @override
  DateTime get selectedDate => DateTime.now();

  @override
  TimeOfDay get selectedTime => TimeOfDay(hour: 8, minute: 30);

  @override
  void selectDate(DateTime date) {
    // You can mock the behavior of this method if needed
  }

  @override
  void selectTime(TimeOfDay time) {
    // You can mock the behavior of this method if needed
  }

  @override
  String getDateString(DateTime date) {
    // You can mock the behavior of this method if needed
    return '';
  }

  @override
  String getTimeString(BuildContext context, TimeOfDay time) {
    // You can mock the behavior of this method if needed
    return '08:30 AM';
  }

  @override
  DateTime getSelectedDateTime() {
    // You can mock the behavior of this method if needed
    return DateTime.now();
  }
}

class MockDatabaseProvider extends Mock implements DatabaseProvider {
  @override
  Future<bool> insertWeatherData(
      parameter, timeStamp, stationId, parameterValue) async {
    return true;
  }

  @override
  Future<UserDataModel> readUserData(any) async {
    return UserDataModel(
      firstName: 'John',
      lastName: 'Doe',
      phoneNumber: '+1234567890',
      emailAddress: 'john.doe@example.com',
      occupation: 'Developer',
      userAge: 30,
      gender: 'Male',
      stationIds: ['TEST9999'],
    );
  }

  @override
  Future<bool> insertUserData(any) async {
    return true;
  }
}

class MockProfileProvider extends Mock implements ProfileProvider {
  @override
  // TODO: implement stationIds
  List? get stationIds => ['TEST9999'];

  @override
  bool get isEditProfileDetails => false;
}

class MockAuthProvider extends Mock implements SignInProvider {
  @override
  String get userId => 'testUserId';

  @override
  bool get isLoggedIn => false;
}
