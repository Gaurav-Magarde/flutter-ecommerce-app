import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  String targetScreen;
  bool active;

  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  /// Convert a [BannerModel] to a [Map_json]
  Map<String ,dynamic> toJson(){
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }

  /// Convert a [DocumentSnapshot] to a [BannerModel]
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;

    return BannerModel(
      imageUrl: data['ImageUrl'] ?? '',
      targetScreen: data['TargetScreen']?? " ",
      active: data['Active'] ?? false,
    );
  }
}
