import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ProfileProvider with ChangeNotifier {
  bool _isEditProfileDetails = false;

  bool get isEditProfileDetails => _isEditProfileDetails;

  void setProfileEditFlag(bool isEditProfileDetails) {
    _isEditProfileDetails = isEditProfileDetails;
    notifyListeners();
  }
}
