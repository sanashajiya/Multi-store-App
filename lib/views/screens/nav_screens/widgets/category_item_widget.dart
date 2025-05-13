import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_cart/controllers/category_controller.dart';
import 'package:smart_cart/models/category.dart';
import 'package:smart_cart/providers/category_provider.dart';
import 'package:smart_cart/views/screens/details/screens/inner_category_screen.dart';
import 'package:smart_cart/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategoryItemWidget extends ConsumerStatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  ConsumerState<CategoryItemWidget> createState() => CategoryItemWidgetState();
}

class CategoryItemWidgetState extends ConsumerState<CategoryItemWidget> {
  // A future that will hold the list of categories once loaded from the API

  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    final categoryController = CategoryController();
    try {
      final categories = await categoryController.loadCateegories();
      ref.read(categoryProvider.notifier).setCategories(categories);
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(title: 'Categories', subtitle: 'View all'),
        GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return InnerCategoryScreen(category: category);
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network(
                                category.image,
                                height: 47,
                                width: 47,
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                category.name,
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
      ],
    );
  }
}