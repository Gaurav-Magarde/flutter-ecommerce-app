import 'package:clone_shopping/data/repositries/dataRepositries/reposetry_authentication.dart';
import 'package:clone_shopping/features/shop/models/cart_model/CartModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';


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
    } on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code).message;
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException().message;
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
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
    } on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code).message;
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException().message;
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      final path = FirebaseFirestore.instance
          .collection("users")
          .doc(user.user!.uid)
          .collection("Cart");
      await path.doc(id).delete();
    }  on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code).message;
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException().message;
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
