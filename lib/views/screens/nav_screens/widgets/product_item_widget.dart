// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smart_cart/models/product.dart';
import 'package:smart_cart/providers/cart_provider.dart';
import 'package:smart_cart/providers/favorite_provider.dart';
import 'package:smart_cart/services/manage_http_response.dart';
import 'package:smart_cart/views/screens/details/screens/product_detail_screen.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  final Product product;
  const ProductItemWidget({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
     final cartProviderObject = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.product.id);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(product: widget.product);
        }));
      },
      child: Container(
        width: 170,
        margin: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Image.network(
                    widget.product.images[0],
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    right: 0,
                    child:  InkWell(
                      onTap: () {
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
                        child:
                            favoriteProviderData.getFavoriteItems.containsKey(
                                  widget.product.id,
                                )
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(Icons.favorite_border),
                      ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
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
                            showSnackBar(context, "Added ${widget.product.productName} to cart",);
                          },
                      child: Image.asset(
                        'assets/icons/cart.png',
                        height: 26,
                        width: 26,
                      ),
                    ),
                    
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 8,
            // ),
            Text(
              widget.product.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Color(
                  0xFF212121,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.product.averageRating == 0? SizedBox() : Row(
              children: [
                Icon(
                  Icons.star, 
                  color: Colors.amber,
                  size: 12,
                  ),
                  SizedBox(width: 4,),
                  Text(
                    widget.product.averageRating.toStringAsFixed(1),
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

              ],
            ),
            // const SizedBox(
            //   height: 4,
            // ),
            Text(
              widget.product.category,
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xff868D94,
                  )),
            ),
            Text(
              '\$${widget.product.productPrice.toStringAsFixed(2)}', 
            style: 
            GoogleFonts.montserrat(
              fontSize: 15, 
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),),
          ],
        ),
      ),
    );
  }
}
