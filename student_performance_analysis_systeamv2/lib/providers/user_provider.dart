import 'package:flutter/material.dart';
import '../models/user.dart'; // Ensure this path is correct

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    token: '',
    password: '',
    userType: '',
    age: 0,
    bloodType: '',
    userClass: '',
    department: '',
    sex: '',
  );

  User get user => _user;

  void setUser(String userJson) {
    _user = User.fromJson(userJson);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
