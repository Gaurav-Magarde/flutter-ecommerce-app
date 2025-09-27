
import 'package:clone_shopping/features/shop/models/cart_model/CartModel.dart';
import 'package:clone_shopping/features/shop/models/product_model.dart';
import 'package:clone_shopping/features/shop/models/product_variation.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../Repositries/cart_repository.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxList<CartModel> cartItems = <CartModel>[].obs;
  RxInt  totalPrice = 0.obs;
  RxInt  salePrice = 0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    Get.lazyPut(() => CartRepository());
    fetchCartProducts();
    super.onInit();
  }

  Future<void> fetchCartProducts() async {
    try {
      isLoading.value = true;
      final data = await CartRepository.instance.fetchCartProducts();
       if(data.isNotEmpty) cartItems.value = data;

      _totalPrice();
    } catch (e) {
      TLoaders.errorSnackBar(title: "ohSnap by cart ", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _totalPrice(){

    for (CartModel item in cartItems) {
      totalPrice.value += (item.quantity * (item.price.toInt()));
      salePrice.value += (item.quantity * (item.salePrice.toInt()));
    }
  }

  Future<void> addToCart({
    required ProductModel product,
    required ProductVariationModel variation,
    required int quantity,
    String? color,
    String? size,
  }) async {
    try {
      isLoading.value = true;
      final cartItem = CartModel(
        salePrice: product.salePrice.toInt(),
        brand: product.brand?.name ?? "Not Verified",
        quantity: quantity,
        price: product.price,
        image: variation.image,
        title: product.title,
        color: color,
        size: size,
        productId: product.id,
      );
      await CartRepository.instance.addToCart(cartItem);
      cartItems.add(cartItem);
      TLoaders.successSnackBar(
        title: "Successfully Added",
        message: "your item is successfully added to cart",
      );
      totalPrice.value += ((product.price.toInt()) * quantity);
      salePrice.value += ((product.salePrice.toInt()) * quantity);
    } catch (e) {
      TLoaders.errorSnackBar(title: "ohSnap", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      isLoading.value = true;
      await CartRepository.instance.removeFromCart(id);

      for (CartModel item in cartItems) {
        if (item.productId == id) {
          cartItems.remove(item);
          totalPrice.value -= ( item.quantity *  ( item.price.toInt()));
          salePrice.value -= ( item.quantity *  ( item.salePrice.toInt()));
          if(totalPrice.value<0) totalPrice.value=0;
          if(salePrice.value<0) salePrice.value=0;
          TLoaders.successSnackBar(
            title: "Successfully Removed",
            message: "your item is successfully removed from cart",
          );
          break;
        }

      }
    } catch (e) {
      TLoaders.errorSnackBar(title: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
