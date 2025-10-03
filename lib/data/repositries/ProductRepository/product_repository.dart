import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final products = await FirebaseFirestore.instance
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .where("NoOfProductVariations", isGreaterThan: 0)
          .limit(6)
          .get();
      return products.docs
          .map((product) => ProductModel.fromSnapshot(product))
          .toList();
    }
    // Catch specific Firebase Authentication errors.
    on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code);
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException();
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code);
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {

      final querySnapshot = await query.get();

      final list = querySnapshot.docs
          .map((product) => ProductModel.fromQuerySnapshot(product))
          .toList();
      return list;
    }
    // Catch specific Firebase Authentication errors.
    on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code);
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException();
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code);
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
    String categoryId, {
    int limit = 2,
  }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> products ;
      if(limit == -1) {
        products = await FirebaseFirestore.instance
          .collection('Products')
          .where('CategoryId', isEqualTo: categoryId)
          .get();
      }else{
        products = await FirebaseFirestore.instance
            .collection('Products')
            .where('CategoryId', isEqualTo: categoryId)
            .limit(limit)
            .get();
      }

      return products.docs
          .map((product) => ProductModel.fromSnapshot(product))
          .toList();
    } on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code);
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException();
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code);
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Future<void> uploadDummyProducts() async {
  //   final db = FirebaseFirestore.instance;
  //
  //   for (final product in dummyProducts) {
  //     if(product.productVariations.isEmpty) continue;
  //     await db.collection("Products").doc(product.id).set(product.toJson());
  //   }
  // }
}
