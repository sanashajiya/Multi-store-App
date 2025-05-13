import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_cart/models/product.dart';

class ProductProvider extends StateNotifier<List<Product>> {
  ProductProvider() : super([]);

  // Set the list of products
  void setProducts(List<Product> products) {
    state = products;
  }

  // Get the list of products
  List<Product> get products => state;

  // Add a product to the list
  void addProduct(Product product) {
    state = [...state, product];
  }
}

final productProvider = StateNotifierProvider<ProductProvider, List<Product>>(
  (ref) => ProductProvider(),
);