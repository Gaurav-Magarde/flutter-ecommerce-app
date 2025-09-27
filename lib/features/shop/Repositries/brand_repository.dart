import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../models/brand_model.dart';

class BrandRepository extends GetxController {

  static BrandRepository get instance => Get.find();

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
}
