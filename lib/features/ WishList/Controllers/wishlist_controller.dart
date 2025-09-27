import 'package:clone_shopping/features/shop/models/product_variation.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../shop/models/product_model.dart';
import '../Model/wishlist_model.dart';
import '../Repository/wishlist_repository.dart';

class WishListController extends GetxController {
  static WishListController get instance => Get.find();

  RxBool isLoading = false.obs;

  RxSet<String> wishListId = <String>{}.obs;
  RxList<WishListModel> wishList = <WishListModel>[].obs;

  @override
  void onInit() {
    Get.put(WishListRepository());
    fetchWishList();
    super.onInit();
  }

  bool isWishListed(String productId) {
    return wishListId.contains(productId);
  }

  Future<void> fetchWishList() async {
    try {
      isLoading.value = true;
      final list = await Get.find<WishListRepository>().fetchWishList();
      wishList.assignAll(list);
      wishListId.assignAll(list.map((e) => e.productId).toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh snap! from wishlist", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleWishList({
    required ProductModel product,
    required ProductVariationModel variation,
  }) async {
    try {
      isLoading.value = true;
      bool flag = wishListId.contains(product.id);
      String off = ((variation.price / variation.salePrice) * 100)
          .ceil()
          .toString();

      if (!flag) {
        final item = WishListModel(
          image: variation.image,
          productId: product.id,
          title: product.title,
          brand: product.brand?.name ?? "",
          off: '',
        );
        await Get.find<WishListRepository>().addToWishList(item);
        TLoaders.successSnackBar(
          title: "Success",
          message: "Item added to wishlist",
        );
        wishList.add(item);
        wishListId.add(product.id);
      } else {
        isLoading.value = true;
        await Get.find<WishListRepository>().removeFromList(product.id);
        TLoaders.successSnackBar(
          title: "Success",
          message: "Item removed from wishlist",
        );
        wishList.removeWhere((element) => element.productId == product.id);
        wishListId.remove(product.id);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromWishList(String id) async {
    try {
      isLoading.value = true;
      await Get.find<WishListRepository>().removeFromList(id);
      TLoaders.successSnackBar(
        title: "Success",
        message: "Item removed from wishlist",
      );
      wishList.removeWhere((element) => element.productId == id);
      wishListId.remove(id);
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
