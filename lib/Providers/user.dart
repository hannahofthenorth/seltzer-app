import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class User with ChangeNotifier {
  final String firstName;
  final String lastName;
  final String userName;
  // profilePicture
  // birthday

  final String userId;

  User({
    @required this.firstName,
    @required this.lastName,
    @required this.userName,
    @required this.userId,
  });

  Future<void> addNewUser(User user, String authToken) async {
    final url =
        'https://seltzer-rating-app-default-rtdb.firebaseio.com/users.json?auth=$authToken';
    try {
      await http.post(
        url,
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'userName': userName,
          'userId': userId,
        }),
      );
    } catch (error) {
      throw error;
    }
  }
}
