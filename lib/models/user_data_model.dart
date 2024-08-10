import 'dart:ffi';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserDataModel {
  final String? firstName;
  final String? lastName;
  final PhoneNumber? phoneNumber;
  final String? emailAddress;
  final String? occupation;
  final Int? userAge;
  final String? gender;
  final Array? stationIds;

  UserDataModel(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      this.emailAddress,
      this.occupation,
      this.userAge,
      this.gender,
      required this.stationIds});
}
