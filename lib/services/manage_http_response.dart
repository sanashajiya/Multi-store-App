import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response, // the HTTP response from the request
  required BuildContext context, // the context is to show snackbar
  required VoidCallback onSuccess, s, // the callback to execute on a successful response
}) {

  try {
    Map<String, dynamic> responseBody = json.decode(response.body);
     //Switch statement to handle http status code
    switch (response.statusCode) {
      case 200:  // status code 200 indicates a successful request
      case 201:  // status code 201 indicates a resource was created successfully
        onSuccess();
        break;
      case 400:  //status code 400 indicates bad request
        showSnackbar(context, responseBody['msg'] ?? "Bad Request");
        break;
      case 500: //status code 500 indicates a server error
        showSnackbar(context, responseBody['error'] ?? "Server error. Please try again later.");
        break;
      default:
        showSnackbar(context, "Unexpected Error: \${response.statusCode} - \${response.body}");
    }
  } catch (e) {
    showSnackbar(context, "Error parsing response: \${e.toString()}");
  }
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
