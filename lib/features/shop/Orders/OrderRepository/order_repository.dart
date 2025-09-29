
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../../../../data/repositries/dataRepositries/reposetry_authentication.dart';
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
      throw 'Something went wrong. Please t r y again';
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

