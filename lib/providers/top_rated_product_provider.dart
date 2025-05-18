import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_cart/models/product.dart';

class TopRatedProductProvider extends StateNotifier<List<Product>> {
  TopRatedProductProvider() : super([]);

  //set the list of products
  void setProducts(List<Product> products) {
    state = products;
  }
}

final topRatedProductProvider =
    StateNotifierProvider<TopRatedProductProvider, List<Product>>((ref) {
  return TopRatedProductProvider();
});