import 'dart:convert';

import 'package:smart_cart/global_variables.dart';
import 'package:smart_cart/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryController {

  // load the uploaded categories from the database
  Future<List<Category>> loadCateegories() async {
    try {
      // send an http get request to load the categories
      http.Response response = await http
          .get(Uri.parse('$uri/api/categories'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      // print(response.body);
      if (response.statusCode == 200) {
        //OK
        List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((item) => Category.fromJson(item)).toList();
        return categories;
      } else if (response.statusCode == 404) {
        return [];
      } 
      else {
        //throw an exception if the server responded with an error status code
        throw Exception('Failed to load Categories: ');
      }
    } catch (e) {
    //   print("Error loading banners: $e");
    // print("StackTrace: $stacktrace");
      throw Exception("Error Loading categories: ");
    }
  }
}
