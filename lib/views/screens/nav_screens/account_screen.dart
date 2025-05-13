import 'package:flutter/material.dart';
import 'package:smart_cart/controllers/auth_controller.dart';
import 'package:smart_cart/views/screens/details/screens/order_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // await _authController.signOutUsers(context: context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OrderScreen();
                },
              ),
            );
          },
          child: Text('My Orders'),
        ),
      ),
    );
  }
}
