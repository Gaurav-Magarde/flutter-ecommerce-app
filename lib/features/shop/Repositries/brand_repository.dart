import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

class BrandRepository extends GetxController {

  static BrandRepository get instance => Get.find<BrandRepository>();

  Future<List<BrandModel>> fetchAllBrands() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Brands")
          .get();

      final result = querySnapshot.docs
          .map((e) => BrandModel.fromSnapshot(e))
          .toList();

      return result;
    } on FirebaseException catch (e) {
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

  Future<List<BrandModel>> fetchBrandsForCategory(String categoryId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("BrandCategories")
            .where("categoryId", isEqualTo: categoryId)
          .get();
      // querySnapshot.docs.map((e) => print(e.data()['brandId']));
      List<String> brandIds = querySnapshot.docs.map((e) => e.data()['brandId'] as String).toList();
      if(brandIds.isEmpty) return [];
      final brandQuery = await FirebaseFirestore.instance.collection("Brands").where(FieldPath.documentId, whereIn: brandIds).limit(2).get();
      final result = brandQuery.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
      // Catch errors related to incorrect data format.
    } on FormatException catch (_) {
      throw const TFormatException();
      // Catch errors from the underlying native platform (Android/iOS)
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
      // Catch any other unexpected errors.
    } catch (e) {
      throw 'Something went wrong. Please try again   ..';
    }
  }

  Future<List<ProductModel>> fetchProductsForBrand(
      {required String brandId, int limit = 2}) async {
    
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Products")
          .where("brandId", isEqualTo: brandId).limit(limit)
          .get();
      final result = querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
      // Catch errors related to incorrect data format.
    } on FormatException catch (_) {
      throw const TFormatException();
      // Catch errors from the underlying native platform (Android/iOS)
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
      // Catch any other unexpected errors.
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
