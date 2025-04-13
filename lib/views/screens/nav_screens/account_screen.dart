import 'package:flutter/material.dart';
import 'package:smart_cart/controllers/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _authController.signOutUsers(context: context);
          },
          child: Text('Signout'),
        ),
      ),
    );
  }
}
