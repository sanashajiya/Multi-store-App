import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_cart/controllers/product_controller.dart';
import 'package:smart_cart/models/product.dart';
import 'package:smart_cart/providers/cart_provider.dart';
import 'package:smart_cart/providers/favorite_provider.dart';
import 'package:smart_cart/providers/related_product_provider.dart';
import 'package:smart_cart/services/manage_http_response.dart';
import 'package:smart_cart/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:smart_cart/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadRelatedProducts(
        widget.product.id,
      );
      ref.read(relatedProductProvider.notifier).setProducts(products);
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final relatedProduct = ref.watch(relatedProductProvider);
    final cartProviderObject = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.product.id);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Detail',
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              favoriteProviderData.addProductToFavorite(
                productName: widget.product.productName,
                productPrice: widget.product.productPrice,
                category: widget.product.category,
                image: widget.product.images,
                vendorId: widget.product.vendorId,
                productQuantity: widget.product.quantity,
                quantity: 1,
                productId: widget.product.id,
                description: widget.product.description,
                fullName: widget.product.fullName,
              );
              showSnackBar(
                context,
                "Added ${widget.product.productName} to favorites",
              );
            },
            icon:
                favoriteProviderData.getFavoriteItems.containsKey(
                      widget.product.id,
                    )
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 260,
                height: 275,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 50,
                      child: Container(
                        width: 260,
                        height: 260,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Color(0xFFD8DDFF),
                          borderRadius: BorderRadius.circular(130),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 22,
                      top: 0,
                      child: Container(
                        width: 216,
                        height: 274,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Color(0xFF9CA8FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: SizedBox(
                          height: 300,
                          child: PageView.builder(
                            itemCount: widget.product.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Image.network(
                                widget.product.images[index],
                                width: 198,
                                height: 225,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      widget.product.productName,
                      style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color(0xFF3C55Ef),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "\$${widget.product.productPrice.toString()}",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3C55Ef),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.category,
                style: GoogleFonts.roboto(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            widget.product.totalRatings == 0
                ? Text('')
                : Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(
                        widget.product.averageRating.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('(${widget.product.totalRatings.toString()})'),
                    ],
                  ),
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About",
                    style: GoogleFonts.lato(
                      fontSize: 17,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF363330),
                    ),
                  ),
                  Text(
                    widget.product.description,
                    style: GoogleFonts.radioCanada(letterSpacing: 1),
                  ),
                ],
              ),
            ),
            ReusableTextWidget(title: "Related products", subtitle: ""),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: relatedProduct.length,
                  itemBuilder: (context, index) {
                    final product = relatedProduct[index];
                    return ProductItemWidget(product: product,);
                  }),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap:
              isInCart
                  ? null
                  : () {
                    cartProviderObject.addProductToCart(
                      productName: widget.product.productName,
                      productPrice: widget.product.productPrice,
                      category: widget.product.category,
                      image: widget.product.images,
                      vendorId: widget.product.vendorId,
                      productQuantity: widget.product.quantity,
                      quantity: 1,
                      productId: widget.product.id,
                      description: widget.product.description,
                      fullName: widget.product.fullName,
                    );
                    showSnackBar(context, widget.product.productName);
                  },
          child: Container(
            width: 386,
            height: 46,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isInCart ? Colors.grey : Color(0xFF3B54EE),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                "ADD TO CART",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
