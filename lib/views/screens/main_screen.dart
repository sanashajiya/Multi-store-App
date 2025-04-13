import 'package:flutter/material.dart';
import 'package:smart_cart/views/screens/nav_screens/account_screen.dart';
import 'package:smart_cart/views/screens/nav_screens/cart_screen.dart';
import 'package:smart_cart/views/screens/nav_screens/category_screen.dart';
import 'package:smart_cart/views/screens/nav_screens/favorite_screen.dart';
import 'package:smart_cart/views/screens/nav_screens/home_screen.dart';
import 'package:smart_cart/views/screens/nav_screens/stores_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoriteScreen(),
    CategoryScreen(),
    StoresScreen(),
    CartScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: _pageIndex,
          onTap: (value) {
            // print(value);
            setState(() {
              
              _pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/home.png',
                  width: 25,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/love.png', width: 25),
                label: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Categories"),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/mart.png', width: 25),
                label: "Stores"),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/cart.png', width: 25),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/user.png', width: 25),
                label: "Account"),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
