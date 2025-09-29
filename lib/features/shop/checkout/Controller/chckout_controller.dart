import 'package:clone_shopping/features/personalization/Screens/Address/Models/address_model.dart';
import 'package:clone_shopping/features/personalization/Screens/Address/Repository/addresses_repository.dart';
import 'package:clone_shopping/features/shop/Orders/OrderItemModel/ItemModel.dart';
import 'package:clone_shopping/features/shop/checkout/Controller/paymen_controller.dart';
import 'package:clone_shopping/utils/constants/enums.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/successScreen/successScreen.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../Orders/OrderModel/order_model.dart';
import '../../Orders/OrderRepository/order_repository.dart';
import '../../home/HomeScreen.dart';
import '../../models/cart_model/CartModel.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  @override
  Future<void> onInit() async {
    shippingFee.value = 49;
    calculateTotal();
    fetchDeliveryAddress();
    super.onInit();
  }

  RxBool isLoading = false.obs;

  RxList<CartModel> selectedCartItems = <CartModel>[].obs;
  Rx<AddressModel> selectedDeliveryAddress = AddressModel.empty().obs;
  RxInt subTotal = 0.obs;
  RxInt discount = 0.obs;
  RxInt couponDiscount = 0.obs;
  RxInt shippingFee = 0.obs;
  RxInt salePrice = 0.obs;
  RxInt total = 0.obs;

  Future<void> fetchDeliveryAddress() async {
    final address = await Get.put(AddressRepository()).fetchDefaultAddress();
    if (address != null) selectedDeliveryAddress.value = address;
  }

  int calculateTotal() {
    subTotal.value = 0;
    salePrice.value = 0;
    discount.value = 0;
    total.value = 0;

    for (CartModel item in selectedCartItems) {
      subTotal.value += (item.quantity * (item.price.toInt()));
      salePrice.value += (item.quantity * (item.salePrice.toInt()));
    }
    discount.value = subTotal.value - salePrice.value + couponDiscount.value;
    total.value = subTotal.value - discount.value + shippingFee.value;
    return total.value;
  }

  void checkOut({required AddressModel? address, required int totalItem, required PaymentMethods selectedPaymentMethod}) {
    if (address == null) {
      TLoaders.warningSnackBar(
        title: "Empty Address",
        message: "Please add delivery address before checkout ",
      );
      return;
    }
    if (totalItem < 1) {
      TLoaders.warningSnackBar(
        title: "Empty cart",
        message: "Please select items to buy before checkout ",
      );
      return;
    }
    if(selectedPaymentMethod == PaymentMethods.payOnDelivery){

      placeOrder("12321231");

    }else{
          Get.find<PaymentController>().completePayment(total.value);
    }
  }

  Future<void> placeOrder(String orderId) async {
    try{
      final orderRepository = Get.put(OrderRepository());
      final List<ItemModel> items = selectedCartItems
          .map(
            (Item) => ItemModel(
          price: Item.price.toInt(),
          quantity: Item.quantity,
          productId: Item.productId,
          title: Item.title,
          image: Item.image,
        ),
      )
          .toList();
      final order = OrderModel(
        items: items,
        discount: discount.value,
        shippingFee: shippingFee.value,
        deliveryAddress: selectedDeliveryAddress.value,
        totalItemsPrice: total.value,
        orderId: orderId,
        orderStatus: OrderStatus.shipped,
        orderDate: DateTime.now().toString(),
        deliveryDate: DateTime.timestamp().toString(),


      );
      print("here");
      await orderRepository.placeOrder(order);
      Get.to(
        SuccessScreen(
          image: TImages.successfulPaymentIcon,
          title: "order Successful",
          subTitle: "ThankYou for shopping products .keep buying",
          onPressed: () => Get.to(const HomeScreen()),
        ),
      );
      selectedCartItems.clear();
    }catch(e){
      TLoaders.errorSnackBar(title: "Oh Snap",message: e.toString());
    }
  }
}
