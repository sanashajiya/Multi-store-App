import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_cart/controllers/product_controller.dart';
import 'package:smart_cart/models/product.dart';
import 'package:smart_cart/providers/product_provider.dart';
// import 'package:smart_cart/views/screens/details/screens/widgets/product_item_widget.dart';
import 'package:smart_cart/views/screens/nav_screens/widgets/product_item_widget.dart';
 
class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  ConsumerState<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {
  bool isLoading = false;

  // A Future that will hold the list of popular products
  // late Future<List<Product>> futurePopularProducts;
  @override
  void initState() {
    super.initState();
    // _fetchProduct();
    final products = ref.read(productProvider);
    if (products.isEmpty) {
      _fetchProduct();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

    Future<void> _fetchProduct() async{
      final ProductController productController = ProductController();
      try{
        final products = await productController.loadPopularProducts();
        ref.read(productProvider.notifier).setProducts(products);
      }catch(e){
        print('Error fetching products: $e');
      }finally{
        setState(() {
          isLoading = false;
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
              height: 250,
              child:
              isLoading ? const Center(child: CircularProgressIndicator(color: Colors.blue,),) :
               ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItemWidget(product: product,);
                  }),
            );
  }
}