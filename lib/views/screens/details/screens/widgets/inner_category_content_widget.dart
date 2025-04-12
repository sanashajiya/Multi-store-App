import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controllers/subcategory_controller.dart';
import 'package:multi_store_app/models/category.dart';
import 'package:multi_store_app/models/subcategory.dart';
import 'package:multi_store_app/views/screens/details/screens/widgets/inner_banner_widget.dart';
import 'package:multi_store_app/views/screens/details/screens/widgets/inner_header_widget.dart';
import 'package:multi_store_app/views/screens/details/screens/widgets/subcategory_tile_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;
  const InnerCategoryContentWidget({
    super.key,
    required this.category,
  });

  @override
  State<InnerCategoryContentWidget> createState() => _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState extends State<InnerCategoryContentWidget> {
  late Future<List<Subcategory>> _subcategories;
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    super.initState();
    _subcategories = _subcategoryController
        .getSubcategoriesByCategoryName(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 20),
          child: SizedBox(
            height: 120,
            child: const InnerHeaderWidget(),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Shop by Category",
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.7,
                  ),
                ),
              ),
            ),
            FutureBuilder(
                future: _subcategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // print(snapshot);
                    return Center(
                        child: Text('An error occurred: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No Subcategories'));
                  } else {
                    final subcategories = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: List.generate(
                            (subcategories.length / 7).ceil(), (setIndex) {
                          // for each row, calculate the starting and ending indices
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;

                          // create a padding widget to add spacing around the row
                          return Padding(
                            padding: EdgeInsets.all(8.9),
                            child: Row(
                              // Create a row of the subcategory tie
                              children: subcategories.sublist(
                                start,
                                end>subcategories.length?subcategories.length:end).
                                map((subcategory)=>
                                SubcategoryTileWidget(
                                  image: subcategory.image, 
                                  title: subcategory.subCategoryName
                              ),
                            ).toList(),
                            ),
                            );
                        }),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}