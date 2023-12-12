import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:construction_app/authentication/auth_screen.dart';
import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/screens/cart.dart';
import 'package:construction_app/screens/product_tile.dart';
import 'package:construction_app/screens/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:construction_app/models/category.dart';
import 'package:construction_app/services/service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences? sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'images/animation_500_ko6r2y0h-min.gif',
      'images/animation_500_ko6nwa48-min.gif',
      'images/animation_500_ko6mr4b0-min.gif',
      'images/21005-free-isometric-building-unscreen-min.gif',
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                                // gradient: LinearGradient(
                                //   colors: [
                                //     Color.fromARGB(200, 0, 0, 0),
                                //     Color.fromARGB(0, 0, 0, 0)
                                //   ],
                                //   begin: Alignment.bottomCenter,
                                //   end: Alignment.topCenter,
                                // ),
                                ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            // child: Text(
                            //   'No. ${imgList.indexOf(item)} image',
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 20.0,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 247, 252),
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 15.0, 0.0),
            child: Badge(
              badgeContent: Obx(
                () => Text('${productController.count}'),
              ),
              showBadge: true,
              badgeColor: Colors.deepPurple,
              shape: BadgeShape.circle,
              elevation: 4,
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              position: BadgePosition.topEnd(),
              animationType: BadgeAnimationType.scale,
              toAnimate: true,
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                ),
                onPressed: () {
                  Get.to(Cart());
                },
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
              child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1.5,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              initialPage: 2,
              autoPlay: true,
            ),
            items: imageSliders,
          )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (text) =>
                        productController.fetchProductFilter(text),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: 'Search your construction product...',
                    ),
                  ),
                  // Text(
                  //   'Construction',
                  //   style: TextStyle(
                  //       fontFamily: 'avenir',
                  //       fontSize: 32,
                  //       fontWeight: FontWeight.w900),
                  // ),
                ),
                // IconButton(
                //     icon: const Icon(Icons.view_list_rounded),
                //     onPressed: () {}),
                // IconButton(icon: const Icon(Icons.grid_view), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: productController.productList.length,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  itemBuilder: (context, index) {
                    return ProductTile(productController.productList[index]);
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
