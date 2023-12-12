import 'package:construction_app/models/order.dart';
import 'package:construction_app/services/service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrderController extends GetxController {
  // static OrderController instance = Get.find();
  var isLoading = true.obs;
  RxList<Orders> orderHistory = <Orders>[].obs;
  // var orderHistory = <Orders>[].obs;

  @override
  void onInit() {
    fetchOrderHistory();
    super.onInit();
  }

  //order History

  void fetchOrderHistory() async {
    Services client = Services();

    try {
      isLoading(true);
      var orderList = await client.getOrderHistory();
      // print(productList.value);
      if (orderList != null) {
        orderHistory.value = orderList;
      }
    } finally {
      print(orderHistory.value.toString());

      isLoading(false);
    }
  }
//end
}
