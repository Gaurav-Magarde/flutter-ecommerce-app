import 'package:clone_shopping/features/shop/Orders/OrderController/order_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../utils/constants/enums.dart';
import '../../../personalization/Screens/Address/Models/address_model.dart';
import '../OrderItemModel/ItemModel.dart';

class OrderModel {
  OrderModel({
    required this.items,
    required this.discount,
    required this.shippingFee,
    required this.deliveryAddress,
    required this.totalItemsPrice,

    required this.orderId,
    required this.orderStatus,
    required this.orderDate,
    required this.deliveryDate,
  });

  final int totalItemsPrice;
  final int discount;
  final int shippingFee;
  final String orderId;
  final OrderStatus orderStatus;
  final String orderDate;
  final AddressModel deliveryAddress;
  final List<ItemModel> items;
  final String deliveryDate;

  Map<String, dynamic> toJson(){
    final map = {
      "OrderId": orderId,
      "OrderStatus": orderStatus.name.toString(),
      "OrderDate": orderDate,
      "DeliveryDate": deliveryDate,
      "DeliveryAddress": deliveryAddress.toJson(),
      "Discount": discount,
      "ShippingFee": shippingFee,
      "TotalItemsPrice": totalItemsPrice,
      "Items": items.map((item) => item.toJson()).toList(),
    };
    return map;
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic> ;
    return OrderModel(
      orderId: data['OrderId'] ?? "",
      orderStatus: OrderController.instance.getOrderStatus(data['OrderStatus']),
      orderDate: data['OrderDate'] ?? "",
      deliveryDate: data['DeliveryDate'] ?? "",
      deliveryAddress: AddressModel.fromJson(data['DeliveryAddress']) ,
      discount: data['Discount'] ?? 1450,
      shippingFee: data['ShippingFee'] ?? 49,
      totalItemsPrice: data['TotalItemsPrice'] ?? 45770,
      items: (data['Items'] as List<dynamic>)
          .map((item) => ItemModel.fromJson(item))
          .toList(),
    );
  }

  static Map<String, dynamic> empty() {
    return {
      "OrderId": "",
      "OrderStatus": OrderStatus.shipped,
      "OrderDate": "",
      "DeliveryDate": "",
      "DeliveryAddress": "",
      "Discount": 0,
      "ShippingFee": 0,
      "TotalItemsPrice": 0,
      "Items": [],
    };
  }
  }
