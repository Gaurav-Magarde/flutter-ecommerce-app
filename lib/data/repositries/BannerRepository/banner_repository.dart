import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banner_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController{

  static BannerRepository get instance => Get.find();


  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try{
      final banners = await _db.collection('Banners').where('Active', isEqualTo: true).get();

      return banners.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
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

}