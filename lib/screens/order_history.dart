import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/controllers/order_controller.dart';
import 'package:construction_app/screens/product_tile.dart';
import 'package:construction_app/screens/view_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: Obx(() => Text('${orderController.orderHistory.length}')),
            ),
        body: GetX<OrderController>(
            init: OrderController(),
            builder: (controller) {
              if (controller.isLoading.value == true) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.orderHistory.isEmpty) {
                Text('No orders found');
              }
              return ListView.builder(
                  itemCount: controller.orderHistory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.orange,
                            // ignore: unnecessary_const
                            child: const Text(
                              "#",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            controller.orderHistory[index].id.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Text(
                            controller.orderHistory[index].lineItems![0].name
                                .toString(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => OrderView(
                                              order: controller
                                                  .orderHistory[index],
                                            )));
                              },
                              child: const Text('View')),
                        ),
                      ),
                    );
                  });
            }));
  }
}
