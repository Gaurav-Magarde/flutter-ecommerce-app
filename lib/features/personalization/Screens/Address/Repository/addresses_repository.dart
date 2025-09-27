import 'package:clone_shopping/utils/popups/full_screen_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

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
      if(kDebugMode) print("not passed");

      if(snapshot.docs.isEmpty) return [];
      if(kDebugMode) print("here passed");
      final list = snapshot.docs
          .map((e) => AddressModel.fromSnapshot(e))
          .toList();
      return list;
    } catch (e) {
      rethrow;
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


    } catch (e) {
      rethrow;
    }
  }


  ///change Default address value
  Future<void> changeDefaultAddress({required AddressModel address}) async {
    try {
      final path = FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid);
      await path.update({"DefaultAddress": address.toJson()});
      TFullScreenLoader.stopLoading();
    }catch(e){
      rethrow;
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
    catch(e){
      rethrow;
    }
  }


  /// To upload the updated version of address
  Future<void> updateAddress({required AddressModel address}) async {
    try {
      final path = FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('Addresses');
      await path.doc(address.id).update(address.toJson());

      TFullScreenLoader.stopLoading();


    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeAddress({required String id}) async {
    try {
      final path = FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('Addresses');
      await path.doc(id).delete();
    }catch(e){
      rethrow;
    }
  }

}
