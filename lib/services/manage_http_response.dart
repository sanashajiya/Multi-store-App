import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void manageHttpResponse({
  required http.Response response, // the HTTP response from the request
  required BuildContext context, // the context is to show snackbar
  required VoidCallback
      onSuccess, //the callback to execute on a successful response
}) {
  //Switch statement to handle http status code
  switch (response.statusCode) {
    case 200: // status code 200 indicates a successful request
      //if the request is successful, execute the onSuccess callback
      onSuccess();
      break;
    case 400: //status code 400 indicates bad request
      //if the request is unauthorized, show a snackbar with an appropriate message
      showSnackBar(context, json.decode(response.body)['message']);
      break;
    case 500: //status code 500 indicates a server error
      showSnackBar(context, json.decode(response.body)['error']);
      break;
    case 201: // status code 201 indicates a resource was created successfully
      onSuccess();
      break;

    default:
      //if the status code is not defined, show a generic snackbar with an appropriate message
      showSnackBar(context, response.body);
  }
}

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    margin: EdgeInsets.all(15),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.black,
    content: Text(title)));
}
