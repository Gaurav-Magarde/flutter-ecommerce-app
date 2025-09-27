import 'package:clone_shopping/features/shop/models/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../features/shop/models/product_variation.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController{

  static ProductRepository get instance => Get.find();

  Future<List<ProductModel>> getFeaturedProducts() async {
    try{
        final products = await FirebaseFirestore.instance.collection('Products').where('IsFeatured', isEqualTo: true ).where("NoOfProductVariations" ,isGreaterThan: 0).limit(6).get();
        return products.docs.map(( product)=> ProductModel.fromSnapshot(product)).toList();
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

    Future<List<ProductModel>> fetchProductsByQuery( Query query) async {
      try{
        if(kDebugMode) print("called calledcalledcalledcalledcalledcalledcalled");

        final querySnapshot = await query.get();
        if(kDebugMode) print("get passed  get passed get passed get passed get passed ");

        final list =  querySnapshot.docs.map(( product)=> ProductModel.fromQuerySnapshot(product)).toList();
        if(kDebugMode) print("list passedlist passedlist passedlist passedlist passedlist passedlist passedlist passedlist passed");

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





  // Future<void> uploadDummyProducts() async {
  //   final db = FirebaseFirestore.instance;
  //
  //   for (final product in dummyProducts) {
  //     if(product.productVariations.isEmpty) continue;
  //     await db.collection("Products").doc(product.id).set(product.toJson());
  //   }
  // }






}