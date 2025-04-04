import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controllers/category_controller.dart';
import 'package:multi_store_app/models/category.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryItemWidget> {
  // A future that will hold the list of categories once loaded from the API
  late Future<List<Category>> futureCategories;
  @override
  void initState() {
    super.initState();
    // Fetch categories from the API
    futureCategories = CategoryController().loadCategories();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading categories: ${snapshot.error}');
        } else if (snapshot.data!.isEmpty || !snapshot.hasData) {
          return Text('No categories found');
        } else {
          final categories = snapshot.data!;
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.network(
                      category.image, 
                      height: 47, 
                      width: 47 
                    ),
                  ),
                  Text(category.name,style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              );
            },
          );
        }
      },
    );
  }
}
