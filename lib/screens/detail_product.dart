import 'package:badges/badges.dart';
import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/controllers/product_controller.dart';
import 'package:construction_app/models/product.dart';
import 'package:construction_app/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetail extends StatefulWidget {
  final product;

  ProductDetail({super.key, this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  dynamic argumentData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () async {
    //   await productController
    //       .fetchProductById(argumentData[0]['id'].toString());
    // });
    return Scaffold(
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
                padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                position: BadgePosition.topEnd(),
                animationType: BadgeAnimationType.scale,
                toAnimate: true,
                child: IconButton(
                  icon: const Icon(
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
        body: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.product.images![0].src.toString()),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // child: Text(widget.product.name.toString()),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name.toString(),
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            '₹${widget.product.price.toString()}',
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.shortDescription.toString() != ''
                                  ? widget.product.shortDescription.toString()
                                  : 'No description found this product',
                              // ignore: prefer_const_constructors
                              style:
                                  widget.product.shortDescription.toString() !=
                                          ''
                                      ? const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400)
                                      : const TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     // _decrementButton(),
                      //     // Text(
                      //     //   '1',
                      //     //   style: TextStyle(fontSize: 18.0),
                      //     // ),
                      //     // _incrementButton(),
                      //     // ElevatedButton(
                      //     //     onPressed: () {
                      //     //       productController.addProduct(widget.product);
                      //     //     },
                      //     //     child: Text('Add To Cart'))
                      //   ],
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            productController.addProduct(widget.product);
          },
          child: Container(
            color: Colors.yellow.shade600,
            alignment: Alignment.center,
            height: 50.0,
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}

Widget _incrementButton() {
  return FloatingActionButton(
    child: Icon(Icons.add, color: Colors.black87),
    backgroundColor: Colors.white,
    onPressed: () {},
  );
}

Widget _decrementButton() {
  return FloatingActionButton(
      onPressed: () {},
      child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'),
          color: Colors.black),
      backgroundColor: Colors.white);
}
