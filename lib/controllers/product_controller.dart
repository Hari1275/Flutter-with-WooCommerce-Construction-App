import 'package:construction_app/authentication/auth_screen.dart';
import 'package:construction_app/models/customer.dart';
import 'package:construction_app/models/order.dart';
import 'package:construction_app/models/product.dart';
import 'package:construction_app/screens/cart.dart';
import 'package:construction_app/screens/detail_product.dart';
import 'package:construction_app/screens/home.dart';
import 'package:construction_app/screens/widgets/loading_dailog.dart';
import 'package:construction_app/services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  final dataStore = GetStorage();
  var isLoading = true.obs;
  var productList = <Products>[].obs;

  var productDetails = {}.obs;
  var userDetails = [].obs;
  var userRegDetails = [].obs;

  var productId = 526;
  var productCartList = {}.obs;
  //  RxList<userDetails> userModel = <UserModel>[].obs;
  var cartItems = <Cart>[].obs;

  var context;

  // final userModel = <Vehicle>[].obs;

  // onReady() {
  //   super.onReady();

  // }
  @override
  void onInit() {
    fetchProducts();

    super.onInit();
  }

  void addProduct(Products products) {
    if (productCartList.containsKey(products)) {
      productCartList[products] += 1;
    } else {
      productCartList[products] = 1;
    }
    Get.snackbar(
      "product added",
      "you hve to add the  ${products.name} to cart",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );

    // var productIdList = productCartList.keys.toList();
    // print(productIdList.map((title) => title.toString()));
    // var  = productCartList.values.toList();
    // print();

    // for (var i = 0; i < productCartList.length; i++) {
    //   productCartList[i];

    //   print([i]);
    // }
  }

  get count => productCartList.length;

  // get product

  get product => productCartList();

  //remove

  void removeProduct(Products products) {
    if (productCartList.containsKey(products) &&
        productCartList[products] == 1) {
      productCartList.removeWhere((key, value) => key == products);
    } else {
      productCartList[products] -= 1;
    }
  }

// get subtotal

  get productSubtotal => productCartList.entries
      .map((product) => double.parse(product.key.price) * product.value)
      .toList();

// end

//anther way to get  product subtotal

  double get subTotal => productSubtotal.fold(
      0, (total, current) => total + int.parse(current.price.toString()));

  String get subTotalString => subTotal.toStringAsFixed(2);
//end

//get total

  get total => productCartList.entries
      .map((product) => double.parse(product.key.price) * product.value)
      .toList()
      .reduce((value, element) => value + element);

//end

//delivery fee

  double deliveryFee(productSubtotal) {
    if (productSubtotal >= (30.0)) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  String get deliveryFeeString =>
      deliveryFee(productSubtotal).toStringAsFixed(2);

//end

//free delivery

  String feeDelivery(productSubtotal) {
    print(productSubtotal);

    if (30.0 >= 30.0) {
      return 'You have free delivery';
    } else {
      double missing = 30.0 - 60.0;
      return 'Add Rs.${missing.toStringAsFixed(2)} for Free delivery ';
    }
  }

  String get feeDeliveryString => feeDelivery(productSubtotal);
//end

//sum of sub and delivery fee

  double totalAmount(productSubtotal, deliveryFee) {
    return productSubtotal + deliveryFee(productSubtotal);
  }

  String get totalAmountSting =>
      totalAmount(productSubtotal, deliveryFee).toStringAsFixed(2);
//end
  void fetchProducts() async {
    Services client = Services();

    try {
      isLoading(true);
      var products = await client.getProduct();
      // print(productList.value);
      if (products != null) {
        productList.value = products;
      }
    } finally {
      // print(productList.value);

      isLoading(false);
    }
  }

  //product filter
  void fetchProductFilter(String name) async {
    Services client = Services();

    try {
      isLoading(true);
      var products = await client.getProductFilter(name);
      // print(productList.value);
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }

//end
  Future fetchProductById(String productId) async {
    Services client = Services();

    try {
      isLoading(true);
      var products = await client.getProductById(productId);
      // print(productDetails.value);
      if (products != null) {
        productDetails.value = products as Map;
      }
    } finally {
      print(productDetails.value);

      isLoading(false);
    }
  }

  Future createOrder(
    name,
    lname,
    email,
    phone,
    addressOne,
    addressTwo,
    city,
    state,
    country,
    postal,
    productIds,
  ) async {
    Services client = Services();

    try {
      isLoading(true);

      var products = await client.createOrder(
        name,
        lname,
        email,
        phone,
        addressOne,
        addressTwo,
        city,
        state,
        country,
        postal,
        productIds,
      );
      // print(productDetails.value);
      // print(products);

      if (products.statusCode == 201) {
        // productDetails.value = products as Map;
        // print(productDetails.value);
      }
    } finally {
      isLoading(false);
    }
  }

  //login//

  Future login(email, password) async {
    Services client = Services();

    try {
      isLoading(true);
      var userDetails = await client.login(email, password);
      // print(productDetails.value);

    } finally {
      isLoading(false);
    }
  }
//end

//register

  Future register(name, phone, email, password) async {
    Services client = Services();

    try {
      isLoading(true);

      var userRegDetails = await client.register(name, phone, email, password);
      // print(productDetails.value);

    } finally {
      isLoading(false);
    }
  }
//end

//order History

//end
}
