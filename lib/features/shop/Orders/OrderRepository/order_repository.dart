
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../../../data/repositries/dataRepositries/reposetry_authentication.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../OrderModel/order_model.dart';

class OrderRepository{


  Future<void> placeOrder(OrderModel order) async {
    try {
      final path = FirebaseFirestore.instance
          .collection("users")
          .doc(AuthenticationRepository.instance.user?.uid)
          .collection("orders");
      final completeOrder = order.toJson();
     await path.doc(order.orderId).set(completeOrder);

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


  Future<List<OrderModel>> fetchOrders() async {
    try {
      final path = FirebaseFirestore.instance
          .collection("users")
          .doc(AuthenticationRepository.instance.user?.uid)
          .collection("orders");

      final querySnapshot = await path.get();
      final list = querySnapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
      return list;
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

}

