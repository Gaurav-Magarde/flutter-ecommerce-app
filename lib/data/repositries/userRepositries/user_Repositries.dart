import 'dart:io';

import 'package:clone_shopping/data/repositries/dataRepositries/reposetry_authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/models/UserMode/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Save User Record
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).set(user.toJson());
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

  ///Save User Record
  Future<UserModel> fetchUserRecord() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if(kDebugMode) print("user : $user");
      if(user == null) {
        throw const TFormatException();
      }
      final userRecordDocument = await _db
          .collection("users")
          .doc(user.uid)
          .get();

      final userM = UserModel.fromSnapshot(userRecordDocument);
      return userM;

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

  ///update User Record
  Future<void> updateUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).update(user.toJson());
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

  ///Save User Record
  Future<void> updateSingleUserRecord(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("users")
          .doc(AuthenticationRepository.instance.user!.uid)
          .update(json);
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

  ///Save User Record
  Future<void> deleteUserRecord() async {
    try {
      await _db
          .collection("users")
          .doc(AuthenticationRepository.instance.user?.uid)
          .delete();
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

  ///Upload Profile Picture
  Future<void> uploadProfilePicture() async {
    // final image = FirebaseStorage.instance
  }

  ///Save User Record
  Future<String> changeProfilePicture(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child("${image.name}.G");
      await ref.putFile(File(image.path));
      return await ref.getDownloadURL();
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
