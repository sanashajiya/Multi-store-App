import 'package:http/http.dart' as http;
import 'package:smart_cart/global_variables.dart';
import 'dart:convert';

import 'package:smart_cart/models/subcategory.dart';

class SubcategoryController {
  //load the uploaded sub-categories from the database
  Future<List<Subcategory>> getSubcategoriesByCategoryName(
    String categoryName) async {
  try {
    http.Response response = await http.get(
      Uri.parse('$uri/api/category/$categoryName/subcategories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // print("Response Status: ${response.statusCode}");
    // print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      if (decodedResponse.containsKey('subcategories')) {
        final List<dynamic> data = decodedResponse['subcategories']; // ✅ Extract list correctly
        return data.map((item) => Subcategory.fromJson(item)).toList();
      } else {
        // print("Key 'subcategories' not found in response");
        return [];
      }
    } else if (response.statusCode == 404) {
      // print("Subcategories not found for $categoryName, returning empty list.");
      return [];
    } else {
      // print("Failed to fetch subcategories, Status Code: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    // print("Error fetching categories: $e");
    // print("StackTrace: $stacktrace");
    return [];
  }
}


}
