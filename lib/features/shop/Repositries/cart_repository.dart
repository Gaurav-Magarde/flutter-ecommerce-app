import 'package:clone_shopping/data/repositries/dataRepositries/reposetry_authentication.dart';
import 'package:clone_shopping/features/shop/models/cart_model/CartModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final user = AuthenticationRepository.instance;

  Future<List<CartModel>> fetchCartProducts() async {
    try{
      final path = FirebaseFirestore.instance
          .collection("users")
          .doc(user.user!.uid)
          .collection("Cart");
      final data = await path.get();
      if(data.docs.isEmpty) return [];
      List<CartModel> list = data.docs
          .map((e) => CartModel.fromSnapshot(e))
          .toList();
      return list;
    }catch (e) {
      rethrow;
    }
  }

  Future<void> addToCart(CartModel cartItem) async {
    try {
      final path = FirebaseFirestore.instance
          .collection("users")
          .doc(user.user!.uid)
          .collection("Cart");
      final jsonData = cartItem.toJson();
      final data = await path.doc(cartItem.productId).set(jsonData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      final path = FirebaseFirestore.instance
          .collection("users")
          .doc(user.user!.uid)
          .collection("Cart");
      await path.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
