import 'package:flutter/material.dart';
import 'package:multi_store_app/controllers/banner_controller.dart';
import 'package:multi_store_app/models/banner_model.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {

    //A Future that will hold the list of banners once loaded from the API
  late Future<List<BannerModel>> futurebanners;

  @override
  void initState() {
    super.initState();
    futurebanners = BannerController().loadBanners();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: FutureBuilder(
        future: futurebanners,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // print(snapshot);
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No banners available'));
          } else {
            final banners = snapshot.data!;
            return PageView.builder(
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                      // height: 100,
                      // width: 100,
                    ),
                  );
                });
          }
        }),
      ),
    );
  }
}