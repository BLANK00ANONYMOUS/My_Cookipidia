import 'package:cookipidia/models/user.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class ProfileManager extends ChangeNotifier {
  User get getUser => User(
        firstName: 'Shubham',
        lastName: 'Mahajan',
        role: 'Flutterista',
        profileImageUrl: 'assets/profile_pics/person_shubham.jpeg',
        points: 100,
        darkMode: _darkMode,
      );

  bool get didSelectUser => _didSelectUser;
  bool get didTapOnRaywenderlich => _tapOnRaywenderlich;
  bool get darkMode => _darkMode;

  var _didSelectUser = false;
  var _tapOnRaywenderlich = false;
  var _darkMode = true;

  void set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnRaywenderlich(bool selected) {
    _tapOnRaywenderlich = selected;
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }
}
