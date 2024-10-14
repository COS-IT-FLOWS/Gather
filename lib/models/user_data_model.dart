import 'dart:ffi';

// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserDataModel {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? emailAddress;
  final String? occupation;
  final int? userAge;
  final String? gender;
  // final bool? ifGatherer;
  final List<dynamic>? stationIds;

  UserDataModel(
      {required this.firstName,
      required this.lastName,
      this.phoneNumber,
      this.emailAddress,
      this.occupation,
      this.userAge,
      this.gender,
      // this.ifGatherer,
      this.stationIds});
}
