import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/models/product.dart';
import 'package:construction_app/screens/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTile extends StatelessWidget {
  final Products product;

  const ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(product: product)));
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.network(
                      // product.images['images'].src.toString(),
                      product.images![0].src.toString(),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Positioned(
                  //   right: 0,
                  //   child: Obx(() => CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         child: IconButton(
                  //           icon: product.price.
                  //               ? Icon(Icons.favorite_rounded)
                  //               : Icon(Icons.favorite_border),
                  //           onPressed: () {
                  //             // product.isFavorite.toggle();
                  //           },
                  //         ),
                  //       )),
                  // )
                ],
              ),
              SizedBox(height: 8),
              Text(
                product.name.toString(),
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'avenir', fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              if (product.ratingCount != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.ratingCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\₹${product.price}',
                      style: TextStyle(fontSize: 32, fontFamily: 'avenir')),
                  IconButton(
                      onPressed: () {
                        productController.addProduct(product);
                      },
                      icon: Icon(Icons.add_shopping_cart))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
