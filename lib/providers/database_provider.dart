import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
}
