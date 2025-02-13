import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ProfileProvider with ChangeNotifier {
  bool _isEditProfileDetails = false;
  List<dynamic>? _stationIds = [];

  bool get isEditProfileDetails => _isEditProfileDetails;
  List<dynamic>? get stationIds => _stationIds;

  void setProfileEditFlag(bool isEditProfileDetails) {
    _isEditProfileDetails = isEditProfileDetails;
    notifyListeners();
  }

  void setStationIds(List stationIds) {
    _stationIds = stationIds;
    // notifyListeners();
  }
}
