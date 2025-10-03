import 'package:clone_shopping/features/shop/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {

  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

//  /// GetAll Categories from the firebase

  Future<List<CategoryModel>> getAllCategories() async {

    try{
      final snapshot = await _db.collection("Categories").get();
      final list = snapshot.docs.map((document)=> CategoryModel.fromSnapshot(document)).toList();
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

  Future<List<CategoryModel>> getAllSubCategories({required String categoryId}) async {
    try{  
      final snapShot =  await FirebaseFirestore.instance.collection("Categories").where("ParentId" , isEqualTo: categoryId).get();
      final list = snapShot.docs.map((e)=>CategoryModel.fromSnapshot(e)).toList();
      return list;
      
    }on FirebaseAuthException catch (e) {
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