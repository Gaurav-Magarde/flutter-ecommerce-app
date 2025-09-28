import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';

class PaymentController extends GetxController{

  static PaymentController get instance => Get.find<PaymentController>();

  Rx<PaymentMethods> selectedPaymentMethod = PaymentMethods.upi.obs;

  void changePaymentMethod(PaymentMethods method){
    selectedPaymentMethod.value = method;
  }

  String displayPaymentMethod(PaymentMethods method){
    switch(method){
      case PaymentMethods.upi:
        return "UPI";
      case PaymentMethods.payOnDelivery:
        return "Pay on Delivery";
      }
  }

  String displayPaymentMethodImage(PaymentMethods method) {
    switch (method) {
      case PaymentMethods.upi:
        return TImages.upi;
      case PaymentMethods.payOnDelivery:
        return TImages.cod;
    }
  }

  void completePayment(int price){

  }
}