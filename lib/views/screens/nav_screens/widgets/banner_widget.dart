import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_cart/controllers/banner_controller.dart';
import 'package:smart_cart/models/banner_model.dart';
import 'package:smart_cart/providers/banner_provider.dart';

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({super.key});

  @override
  ConsumerState<BannerWidget> createState() => BannerWidgetState();
}

class BannerWidgetState extends ConsumerState<BannerWidget> {

  @override
  void initState() {
    super.initState();
    _fetchBanners();
  }

  void _fetchBanners() async {
    final bannerController = BannerController();
    try{
      final banners = await bannerController.loadBanners();
      ref.read(bannerProvider.notifier).setBanners(banners);
    }catch(e){
      print('Error fetching banners: $e');
    }
  }
    //A Future that will hold the list of banners once loaded from the API
  late Future<List<BannerModel>> futurebanners;

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannerProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(4),
        ),
        child:  PageView.builder(
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        banner.image,
                        fit: BoxFit.cover,
                        // height: 100,
                        // width: 100,
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}