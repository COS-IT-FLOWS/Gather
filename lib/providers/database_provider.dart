import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gather/models/user_data_model.dart';

class DatabaseProvider with ChangeNotifier {
  final SupabaseClient _supabaseClient;

  DatabaseProvider(this._supabaseClient);

  Future<void> insertWeatherData(
      parameter, timeStamp, stationId, parameterValue) async {
    String dataTable =
        GlobalConfiguration().getDeepValue('DATABASE_CONFIG:$parameter');
    // print(dataTable);

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
        userAge: userData[0]['age']
        // stationIds: userData[0]['station_id']
        );
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
}
