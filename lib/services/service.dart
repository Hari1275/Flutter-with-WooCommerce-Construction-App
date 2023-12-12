import 'dart:convert';

import 'package:construction_app/authentication/auth_screen.dart';
import 'package:construction_app/authentication/register.dart';
import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/models/category.dart';
import 'package:construction_app/models/customer.dart';
import 'package:construction_app/models/order.dart';
import 'package:construction_app/models/product.dart';
import 'package:construction_app/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Services {
  final endPointUrl = "https://example.com.com/wp-json/wc/v1";
  final regPointUrl = "https://example.com.com/wp-json/wp/v2/users/register";
  final loginEndPoint = "https://example.com.com/wp-json/jwt-auth/v1/token";
  final client = http.Client();

  Future<List<Posts>?> getCategory() async {
    final response = await http.get(
      Uri.parse(
        '${endPointUrl}/products/categories',
      ),
      headers: <String, String>{
        'Context-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Basic {{token}}'
      },
    );
    if (response.body == 200) {
      var json = response.body;
      // print(json);
      return postsFromJson(json);
    } else {}
  }

  //get products

  Future<List<Products>?> getProduct() async {
    List<Products> data = [];
    final response = await http.get(
      Uri.parse(
        '${endPointUrl}/products',
      ),
      headers: <String, String>{
        'Context-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Basic {{token}}'
      },
    );

    var json = response.body;

    return productFromJson(json);
  }

  Future<Products> getProductById(id) async {
    List<Products> data = [];
    final response = await http.get(
      Uri.parse(
        '${endPointUrl}/products/${id}',
      ),
      headers: <String, String>{
        'Context-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Basic {{token}}'
      },
    );

    var json = response.body;
    print(json);
    return productDetailFromJson(json);
  }

  //search by product
  Future<List<Products>?> getProductFilter(String name) async {
    List<Products> data = [];
    final response = await http.get(
      Uri.parse(
        '${endPointUrl}/products?filter[name]=${name.toString()}',
      ),
      headers: <String, String>{
        'Context-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Basic {{token}}'
      },
    );
    if (response.statusCode == 200) {
      var json = response.body;

      return productFromJson(json);
    } else {
      return null;
    }
  }
  //end

  Future<http.Response> createOrder(name, lname, email, phone, addressOne,
      addressTwo, city, state, country, postal, productIds) async {
    List<Products> data = [];
    List<Map<String, String>> listItem = <Map<String, String>>[];
    for (var element in productIds) {
      Map<String, String> val = {
        'product_id': element.key.id.toString(),
        'quantity': element.value.toString()
      };
      listItem.add(val);
    }
    print(listItem);
    Map<dynamic, dynamic> body = {
      "  payment_method": "cod",
      "payment_method_title": "Cash on delivery",
      "  set_paid": true,
      "billing": {
        "first_name": name,
        "last_name": lname,
        "address_1": addressOne,
        "address_2": addressTwo,
        "city": city,
        "state": state,
        "postcode": postal,
        "country": country,
        "email": email,
        "phone": phone
      },
      "customer_id": int.parse(productController.dataStore.read("id")),
      "transaction_id": "",
      "line_items": listItem,
    };
    String json = jsonEncode(body);
    final response = await http.post(
        Uri.parse(
          '${endPointUrl}/orders',
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Basic {{token}}'
        },
        body: json);

    print("Response status: ${response.statusCode}");
    if (response.statusCode == 201) {
      productController.productCartList.value = {};
      Get.defaultDialog(
        title: "Succuss",
        titleStyle: TextStyle(fontSize: 20),
        middleText: 'Your order created succussfully',
        textConfirm: "Okay",
        onConfirm: () {
          Get.offAll(Home());
        },
      );
    } else {
      var errData = jsonDecode(response.toString());

      print(errData['message'].toString());
    }

    // print("Response body: ${response.body}");
    // returnesle productDetailFromJson(json);
    return response;
  }

  Future<Token?> login(email, password) async {
    Map<dynamic, dynamic> body = {
      "username": email,
      "password": password,
    };
    print(body);
    String json = jsonEncode(body);
    final response = await http
        .post(
            Uri.parse(
              loginEndPoint,
            ),
            headers: <String, String>{
              "Content-Type": "application/json",
              'Authorization': 'Basic {{token}}'
            },
            body: json)
        .then((res) {
      if (res.statusCode == 200) {
        var userCredential = tokenFromJson(res.body);
        productController.dataStore
            .write("id", userCredential.data!.id.toString());
        productController.dataStore
            .write("token", userCredential.data!.token.toString());
        productController.dataStore
            .write("name", userCredential.data!.displayName.toString());
        Get.offAll(Home());
        Get.snackbar(
          "SUCCUSS",
          'Login succussfully',
        );
        return tokenFromJson(res.body);
      } else {
        var errData = jsonDecode(res.body.toString());

        Get.defaultDialog(
          title: "Error",
          titleStyle: TextStyle(fontSize: 20),
          middleText: '${errData['message'].toString()}',
          textConfirm: "Okay",
          onCancel: () {
            Get.back();
          },
          onConfirm: () {
            Get.back();
          },
        );
      }
    }).catchError((onError) {
      print(onError);
    });

    // return productDetailFromJson(json);

    // var data = jsonDecode(response.body.toString());
    // print(data['data']['token']);
  }

  //register
  Future<Token?> register(name, phone, email, password) async {
    Map<dynamic, dynamic> body = {
      "username": name,
      "email": email,
      "password": password,
    };
    print(body);
    String json = jsonEncode(body);
    final response = await http
        .post(
            Uri.parse(
              regPointUrl,
            ),
            headers: <String, String>{
              "Content-Type": "application/json",
              'Authorization': 'Basic {{token}}'
            },
            body: json)
        .then((res) {
      if (res.statusCode == 200) {
        login(email, password);
        return tokenFromJson(res.body);
      } else {
        var errData = jsonDecode(res.body.toString());

        Get.defaultDialog(
          title: "Error",
          titleStyle: TextStyle(fontSize: 20),
          middleText: '${errData['message'].toString()}',
          textConfirm: "Okay",
          onConfirm: () {
            Get.back();
          },
        );
      }
    }).catchError((onError) {
      print(onError);
    });

    // return productDetailFromJson(json);

    // var data = jsonDecode(response.body.toString());
    // print(data['data']['token']);
  }

  //end

  //order history
  Future<List<Orders>?> getOrderHistory() async {
    List<Products> data = [];
    final response = await http.get(
      Uri.parse(
        '$endPointUrl/orders?customer=${int.parse(productController.dataStore.read("id"))}',
      ),
      headers: <String, String>{
        'Context-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Basic {{token}}'
      },
    );

    var json = response.body;

    if (response.statusCode == 200) {
      print('order details -----> ${json}');

      return ordersFromJson(json.toString());
    } else {
      return null;
    }
  }

  //end
}
