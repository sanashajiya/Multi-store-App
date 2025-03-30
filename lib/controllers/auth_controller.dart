import 'dart:convert';

import 'package:multi_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/services/manage_http_response.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/views/screens/authentication_screen/login_screen.dart';
import 'package:multi_store_app/views/screens/main_screen.dart';

class AuthController {
  Future<void> signUpUsers({
    required BuildContext context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    // Validate fields before API request
    // if (email.isEmpty || fullName.isEmpty || password.isEmpty) {
    //   showSnackbar(context, "All fields are required!");
    //   return;
    // }

    try {
      User user = User(
        id: '',
        email: email,
        fullName: fullName,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          showSnackbar(context, 'Account has been created successfully!');
        },
      );
    } catch (e) {
      showSnackbar(context, "Error: ${e.toString()}");
    }
  }

  // signin users functoin

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email, //include the email in the request body,
          'password': password, //include the password in the request body.
        }),
        headers: <String, String>{
          //this will set the header
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // Handle the response using manage_http_response
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),(route) => false);
          showSnackbar(context, 'Logged In successfully!');
        },
      );
    } catch (e) {
      print('Error:  $e');
    }
  }
}
