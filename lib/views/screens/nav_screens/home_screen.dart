import 'package:flutter/material.dart';
import 'package:smart_cart/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:smart_cart/views/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:smart_cart/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:smart_cart/views/screens/nav_screens/widgets/popular_product_widget.dart';
import 'package:smart_cart/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 120, child: HeaderWidget()),
            BannerWidget(),
            CategoryItemWidget(),
            ReusableTextWidget(
              title: 'Popular Products', 
              subtitle: 'View all'
            ),
            PopularProductWidget(),
          ],
        ),
      ),
    );
  }
}
