import 'package:get/get.dart';
import '../OrderModel/order_model.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../OrderRepository/order_repository.dart';

class OrderController extends GetxController {

  static OrderController get instance => Get.find<OrderController>();

  RxBool isLoading = false.obs;
  RxList<OrderModel> orders =  <OrderModel> [].obs;

  Future<void> placeOrder(OrderModel order) async {
    try{
        final isConnected = await NetworkManager().isConnected();
        if(!isConnected){
          TLoaders.customToast(message: "No Internet Connection");
            return;
        }

        isLoading.value = true;
        final controller  = Get.put(OrderRepository());
        await controller.placeOrder(order);
        TLoaders.successSnackBar(title: "Order Placed ",message: "Your order has been placed successfully");
    }catch(e){
      TLoaders.errorSnackBar(title: "Error",message: e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }

  Future<void> fetchOrders() async {
    try{
      final isConnected = await NetworkManager().isConnected();
      if(!isConnected){
        TLoaders.customToast(message: "No Internet Connection");
        return;
      }

      isLoading.value = true;
      final list =  await OrderRepository().fetchOrders();
      orders.value = list;
    }catch(e){
      TLoaders.errorSnackBar(title: "Error",message: e.toString());
    }
    finally{
      isLoading.value = false;

    }
  }
}

