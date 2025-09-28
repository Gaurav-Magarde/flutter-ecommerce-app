import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String parentId;
  String image;
  bool featured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.parentId,
    required this.image,
    required this.featured,
  });

  ///empty helper function
  static CategoryModel get empty =>
      CategoryModel(id: "1", name: "", parentId: "", image: "", featured: false);


  ///Convert to Json and send the data
  Map<String, dynamic> toJson(){
    return {
      "name":   name,
      "Image" : image,
      "ParentId" : parentId,
      "IsFeatured" : featured
    };
  }

  ///from firebase to UserModel
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>  document ){
    if(document.data()!=null){

      final data   = document.data();
      
      return CategoryModel(
          id: document.id,
          name: data?['Name'] ?? "",
          parentId: data?['ParentId'] ?? "",
          image: data?["Image"] ?? "" ,
          featured: data?["IsFeatured"] ?? false
      );
    }else {
      return empty;
    }

  }
}
