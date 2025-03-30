import 'package:multi_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/services/manage_http_response.dart';
import 'package:flutter/material.dart';

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
          showSnackbar(context, 'Account has been created successfully!');
        },
      );
    } catch (e) {
      showSnackbar(context, "Error: ${e.toString()}");
    }
  }
}
