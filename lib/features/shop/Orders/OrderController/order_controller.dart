import 'package:clone_shopping/features/shop/Orders/Widgets/order_status_helper.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../utils/constants/enums.dart';
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

  OrderStatus getOrderStatus(String status){
    switch(status){
      case "shipped":
        return OrderStatus.shipped;
      case "processing":
        return OrderStatus.processing;
      case "delivered":
        return OrderStatus.delivered;
      case "cancelled":
        return OrderStatus.cancelled;
      case "returned":
        return OrderStatus.returned;
      default:
        return OrderStatus.processing;
    }
  }
}

