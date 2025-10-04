import 'package:clone_shopping/data/repositries/dataRepositries/reposetry_authentication.dart';
import 'package:clone_shopping/features/%20WishList/Model/wishlist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';


class WishListRepository extends GetxController{

  static WishListRepository get instance => Get.find();

  Future<List<WishListModel>> fetchWishList() async {
    try{
       final user = AuthenticationRepository.instance.user;
      final path = FirebaseFirestore.instance.collection("users").doc(user?.uid).collection("Wishlist");
      final docs = await path.get();
      if(docs.docs.isEmpty) return [];
      final list = docs.docs.map((e) => WishListModel.fromJson(e)).toList();
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

  Future<void> addToWishList(WishListModel Item) async {
    try{
      final user = AuthenticationRepository.instance.user;
      final path = FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("Wishlist");
      await path.doc(Item.productId).set(Item.toJson());
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

  Future<void> removeFromList(String productId) async {
    try{
      final user = AuthenticationRepository.instance.user;
      final path = FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("Wishlist");
      await path.doc(productId).delete();
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
}