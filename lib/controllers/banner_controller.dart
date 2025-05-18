import 'dart:convert';

import 'package:smart_cart/global_variables.dart';
import 'package:smart_cart/models/banner_model.dart';
// import 'package:smart_cart/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class BannerController {
  
  //fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      // send an http get request to fetch banners
      http.Response response = await http
          .get(Uri.parse('$uri/api/banner'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      // print(response.body);
      if (response.statusCode == 200) {
        //OK
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((item) => BannerModel.fromJson(item)).toList();
        return banners;
      } else if (response.statusCode == 404) {
        return [];
      }
       else {
        //throw an exception if the server responded with an error status code
        throw Exception('Failed to load banners: ');
      }
    } catch (e) {
    //   print("Error loading banners: $e");
    // print("StackTrace: $stacktrace");
      throw Exception("Error");
    }
  }
}
