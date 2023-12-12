import 'package:construction_app/authentication/auth_screen.dart';
import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/controllers/order_controller.dart';
import 'package:construction_app/controllers/product_controller.dart';
import 'package:construction_app/lang/hi_IN.dart';
import 'package:construction_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.lazyPut(() => ProductController());
  Get.lazyPut(() => OrderController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        supportedLocales: L10n.all,
        debugShowCheckedModeBanner: false,
        // home: productController.dataStore.read('token') != null
        //     ? Home()
        //     : AuthScreen(),
        home: Home());
  }
}
