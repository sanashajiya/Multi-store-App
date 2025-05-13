import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_cart/models/order.dart';

class OrderProvider extends StateNotifier<List<Order>> {
  OrderProvider() : super([]);

  // set the list of orders
  void setOrders(List<Order> orders) {
    state = orders;
  }
}

final orderProvider =
    StateNotifierProvider<OrderProvider, List<Order>>((ref) => OrderProvider());