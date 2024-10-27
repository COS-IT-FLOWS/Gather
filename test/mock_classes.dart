import 'package:gather/models/hazard_data_model.dart';
import 'package:gather/models/user_data_model.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:gather/providers/datetime_provider.dart'; // Adjust imports
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  String getTimeString(TimeOfDay time) {
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
  Future<UserDataModel> readUserData(userId) async {
    if (userId == 'testUserId') {
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
    } else {
      return UserDataModel(
          firstName: '',
          lastName: '',
          phoneNumber: '',
          emailAddress: '',
          occupation: '',
          userAge: 0,
          stationIds: []);
    }
  }

  @override
  Future<bool> insertUserData(any) async {
    return true;
  }

  @override
  Future<String> insertHazardEventDataAndGetHazardId(
      HazardDataModel hazardDataWriteModel) async {
    return 'hazardId';
  }

  @override
  Future<bool> uploadFiles(hazardId, pickedImages, savedFilePath) async {
    return true;
  }
}

class MockProfileProvider extends Mock implements ProfileProvider {
  List _stationIds = [];
  bool _isEditProfileDetails = false;

  @override
  List? get stationIds => _stationIds;

  @override
  bool get isEditProfileDetails => _isEditProfileDetails;

  void setStationIdsForUser(String userId) {
    if (userId == 'testUserId') {
      _stationIds = ['TEST9999'];
    } else {
      _stationIds = [];
    }
  }
}

class MockAuthProvider extends Mock implements SignInProvider {
  String _userId = '';
  bool _isLoggedIn = false;
  String _phoneNumber = '9999999999';

  @override
  String get userId => _userId;

  @override
  bool get isLoggedIn => _isLoggedIn;

  // @override
  String get phoneNumber => _phoneNumber;

  void logIn(String userId) {
    _userId = userId;
    _isLoggedIn = true;
  }

  void logOut() {
    _userId = '';
    _isLoggedIn = false;
  }

  @override
  verifyOtp(String otp) async {
    _userId = userId;
    _isLoggedIn = true;
  }

  @override
  Future<String> signInWithGoogle() async {
    String inputUserId = 'testUserId';
    _userId = inputUserId;
    _isLoggedIn = true;
    return inputUserId;
  }

  @override
  Future<bool> signInWithPhoneNumber(phoneNumber) async {
    // _isLoggedIn = true;
    return true;
  }
}

class MockAuthFailedProvider extends Mock implements SignInProvider {
  String _userId = '';
  bool _isLoggedIn = false;

  @override
  String get userId => _userId;

  @override
  bool get isLoggedIn => _isLoggedIn;

  void logIn(String userId) {
    _userId = userId;
    _isLoggedIn = true;
  }

  void logOut() {
    _userId = '';
    _isLoggedIn = false;
  }

  @override
  verifyOtp(String otp) async {
    _userId = userId;
    _isLoggedIn = true;
  }

  @override
  Future<String> signInWithGoogle() async {
    String inputUserId = '';
    _userId = inputUserId;
    _isLoggedIn = false;
    return inputUserId;
  }
}

class MockImagePicker extends Mock implements ImagePicker {
  @override
  Future<List<XFile>> pickMultiImage(
      {double? maxWidth,
      double? maxHeight,
      int? imageQuality,
      int? limit,
      bool requestFullMetadata = true}) async {
    List<XFile> imageFiles = [
      XFile('path/to/image1.jpg'),
      XFile('path/to/image2.jpg')
    ];
    return imageFiles;
  }

  @override
  Future<XFile> pickImage(
      {int? imageQuality,
      double? maxHeight,
      double? maxWidth,
      CameraDevice preferredCameraDevice = CameraDevice.rear,
      bool requestFullMetadata = true,
      required ImageSource source}) async {
    return XFile('path/to/camera_image.jpg');
  }
}
