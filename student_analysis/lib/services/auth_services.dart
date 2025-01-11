import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Entry.dart';
import '../models/user.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AuthService {
  //xxxxxxxxxxxxxxxxxxxxxxxx signUp  xxxxxxxxxxxxxxxxxxxxxxxxxxx
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        name: name,
        password: password,
        email: email,
      );

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        body: jsonEncode(user.toMap()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        showSnackBar(
            context, 'Account created! Login with the same credentials!');
      } else {
        throw Exception('Failed to sign up: ${res.body}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //xxxxxxxxxxxxxxxxxxxxxxxx login xxxxxxxxxxxxxxxxxxxxxxxxxxx
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required Widget nextScreen,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userProvider.setUser(res.body);
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => nextScreen),
          (route) => false,
        );
      } else {
        throw Exception('Login failed: ${res.body}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //xxxxxxxxxxxxxxxxxxxxxxxx logout  xxxxxxxxxxxxxxxxxxxxxxxxxxx
  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Entry_door()),
      (route) => false,
    );
  }

  //xxxxxxxxxxxxxxxxxxxxxxxx get user data xxxxxxxxxxxxxxxxxxxxxxxxxxx
  Future<void> getUserData(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token == null) {
      prefs.setString('x-auth-token', '');
      return;
    }

    http.Response tokenRes = await http.post(
      Uri.parse('${Constants.uri}/tokenIsValid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
    );

    if (jsonDecode(tokenRes.body) == true) {
      http.Response userRes = await http.get(
        Uri.parse('${Constants.uri}/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (userRes.statusCode == 200) {
        userProvider.setUser(userRes.body);
      } else {
        throw Exception('Failed to fetch user data: ${userRes.body}');
      }
    } else {
      showSnackBar(context, 'Token is not valid');
    }
  }
}
