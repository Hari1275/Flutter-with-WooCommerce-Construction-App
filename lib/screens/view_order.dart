import 'package:construction_app/models/order.dart';
import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  Orders order;
  OrderView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Order Details #${order.id.toString()}',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child:
                                  Text('Order Number: ${order.id.toString()}')),
                          Expanded(
                            child: Text(
                                'Product Name: ${order.lineItems![0].name.toString()}'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                                'Price: ${order.lineItems![0].price.toString()}'),
                          ),
                          Expanded(
                            child: Text(
                                'Quantity: ${order.lineItems![0].quantity.toString()}'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                                  'Total Amount: ${order.total.toString()}')),
                          Expanded(
                            child: Text(order.status.toString(),
                                style: TextStyle(
                                    color: order.status.toString() == 'pending'
                                        ? Colors.orange
                                        : order.status.toString() == 'completed'
                                            ? Colors.green
                                            : Colors.amber)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
