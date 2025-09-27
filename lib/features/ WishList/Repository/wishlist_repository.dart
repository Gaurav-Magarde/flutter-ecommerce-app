import 'package:clone_shopping/data/repositries/dataRepositries/reposetry_authentication.dart';
import 'package:clone_shopping/features/%20WishList/Model/wishlist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


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
    }catch(e){
      rethrow;
    }
  }

  Future<void> addToWishList(WishListModel Item) async {
    try{
      final user = AuthenticationRepository.instance.user;
      final path = FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("Wishlist");
      await path.doc(Item.productId).set(Item.toJson());
    }catch(e){
      rethrow;
    }
  }

  Future<void> removeFromList(String productId) async {
    try{
      final user = AuthenticationRepository.instance.user;
      final path = FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("Wishlist");
      await path.doc(productId).delete();
    }catch(e){
      rethrow;
    }
  }
}