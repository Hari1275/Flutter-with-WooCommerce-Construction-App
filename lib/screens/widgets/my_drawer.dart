import 'package:construction_app/authentication/auth_screen.dart';
import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/screens/home.dart';
import 'package:construction_app/screens/order_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hello, ${productController.dataStore.read("name")}",
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const Home()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                    leading: const Icon(
                      Icons.local_shipping,
                      color: Colors.black,
                    ),
                    title: const Text(
                      "History - Orders",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Get.to(OrderHistory());
                    }),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    productController.dataStore.erase();

                    Get.offAll(AuthScreen());
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
