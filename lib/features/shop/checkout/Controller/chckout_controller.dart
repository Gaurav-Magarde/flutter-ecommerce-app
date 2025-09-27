import 'package:clone_shopping/features/personalization/Screens/Address/Models/address_model.dart';
import 'package:clone_shopping/features/personalization/Screens/Address/Repository/addresses_repository.dart';
import 'package:get/get.dart';

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
    final address = await Get.put(
      AddressRepository(),
    ).fetchDefaultAddress();
    if(address!= null) selectedDeliveryAddress.value = address;
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
}
