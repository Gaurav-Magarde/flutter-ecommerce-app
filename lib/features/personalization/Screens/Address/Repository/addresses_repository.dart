import 'package:clone_shopping/utils/popups/full_screen_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../../utils/exceptions/format_exceptions.dart';
import '../../../../../utils/exceptions/platform_exceptions.dart';
import '../Models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  /// Fetch Addresses from Firebase
  Future<List<AddressModel>> fetchAddresses() async {
    try {
      final path = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Addresses');
      final snapshot = await path.get();

      if(snapshot.docs.isEmpty) return [];
      final list = snapshot.docs
          .map((e) => AddressModel.fromSnapshot(e))
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


  /// create new address into the firebase
  Future<void> addNewAddress({required AddressModel address,required bool isDefault}) async {
    try {
      final path = FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('Addresses');
      await path.doc(address.id).set(address.toJson());
     if(isDefault) {
      await changeDefaultAddress(address: address);
     }

      TFullScreenLoader.stopLoading();


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


  ///change Default address value
  Future<void> changeDefaultAddress({required AddressModel address}) async {
    try {
      final path = FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid);
      await path.update({"DefaultAddress": address.toJson()});
      TFullScreenLoader.stopLoading();
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


  /// To fetch detail address at the starting
  Future<AddressModel?> fetchDefaultAddress() async {
    try {
      final path = FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid);
      final snapshot = await path.get();
      final data = snapshot.data();
      if(data ==null || data['DefaultAddress'] == null) return null;
      return AddressModel.fromJson(data['DefaultAddress']);

    }
    on FirebaseAuthException catch (e) {
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


  /// To upload the updated version of address
  Future<void> updateAddress({required AddressModel address}) async {
    try {
      final path = FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('Addresses');
      await path.doc(address.id).update(address.toJson());

      TFullScreenLoader.stopLoading();


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

  Future<void> removeAddress({required String id}) async {
    try {
      final path = FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('Addresses');
      await path.doc(id).delete();
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
