import 'dart:io';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gather/models/user_data_model.dart';
import 'package:gather/models/hazard_data_model.dart';

class DatabaseProvider with ChangeNotifier {
  final SupabaseClient _supabaseClient;

  DatabaseProvider(this._supabaseClient);

  Future<void> insertWeatherData(
      parameter, timeStamp, stationId, parameterValue) async {
    String dataTable =
        GlobalConfiguration().getDeepValue('DATABASE_CONFIG:$parameter');
    await _supabaseClient.from(dataTable).insert(
        {'collected_at': timeStamp.toString(), stationId: parameterValue});
  }

  Future<void> readWeatherData(param) async {}

  Future<UserDataModel> readUserData(userId) async {
    final userData =
        await _supabaseClient.from('profiles').select('*').eq('id', userId);
    UserDataModel userDataModel = UserDataModel(
        firstName: userData[0]['first_name'],
        lastName: userData[0]['last_name'],
        phoneNumber: userData[0]['phone_number'],
        emailAddress: userData[0]['email'],
        occupation: userData[0]['occupation'],
        userAge: userData[0]['age'],
        stationIds: userData[0]['station_id']);
    return userDataModel;
    // UserDataModel userDataModel = UserDataModel()
  }

  Future<void> insertUserData(UserDataModel userDataWriteModel) async {
    await _supabaseClient.from('profiles').upsert({
      'first_name': userDataWriteModel.firstName,
      'last_name': userDataWriteModel.lastName,
      'phone_number': userDataWriteModel.phoneNumber,
      'email': userDataWriteModel.emailAddress,
      'occupation': userDataWriteModel.occupation,
      'age': userDataWriteModel.userAge
    });
  }

  Future<String> insertHazardEventDataAndGetHazardId(
      HazardDataModel hazardDataWriteModel) async {
    final hazardData = await _supabaseClient
        .from('hazard_events')
        .upsert({
          'type': hazardDataWriteModel.hazardType,
          'description': hazardDataWriteModel.hazardDescription,
        })
        .select('id')
        .single();
    final hazardId = hazardData['id'];
    return hazardId;
  }

  Future<void> uploadFiles(hazardId, pickedImages, savedFilePath) async {
    // final storage = _supabaseClient.storage;
    for (var filePath in pickedImages) {
      final fileName = filePath.path.split('/').last;
      await _supabaseClient.storage
          .from('hazard_event_media')
          .upload('$hazardId/$fileName', filePath);
    }
    print(savedFilePath);
    if (savedFilePath != null && savedFilePath != '') {
      final savedFile = File(savedFilePath);
      final fileName = savedFile.path.split('/').last;
      await _supabaseClient.storage
          .from('hazard_event_media')
          .upload('$hazardId/$fileName', savedFile);
    }
  }
} // End of DatabaseProvider
