import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/controllers/product_controller.dart';
import 'package:construction_app/models/product.dart';
import 'package:construction_app/screens/cart_total.dart';
import 'package:construction_app/screens/checkout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          height: 800,
          child: Obx(
            () => Column(
              children: [
                Expanded(
                  child: productController.productCartList.isEmpty
                      ? Center(child: Text('Cart is empty ☹️'))
                      : Container(
                          child: ListView.builder(
                              itemCount:
                                  productController.productCartList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CartProductCard(
                                  product: productController
                                      .productCartList.keys
                                      .toList()[index],
                                  quantity: productController
                                      .productCartList.values
                                      .toList()[index],
                                  index: index,
                                  controller: productController,
                                );
                              }),
                        ),
                ),
                if (productController.productCartList.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text('₹${productController.total}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Checkout(),
                                        ));
                                  },
                                  child: const Text('Checkout'))),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final Products product;
  final ProductController controller;
  final int quantity;
  final int index;
  const CartProductCard(
      {super.key,
      required this.product,
      required this.quantity,
      required this.index,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color.fromARGB(255, 240, 237, 237),
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      NetworkImage(product.images![0].src.toString()),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(child: Text(product.name.toString())),
                IconButton(
                    onPressed: () {
                      controller.removeProduct(product);
                    },
                    icon: Icon(Icons.remove_circle)),
                Text('${quantity}'),
                IconButton(
                    onPressed: () {
                      controller.addProduct(product);
                    },
                    icon: Icon(Icons.add_circle)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
