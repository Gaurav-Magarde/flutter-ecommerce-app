import 'package:clone_shopping/features/shop/Orders/OrderRepository/order_repository.dart';
import 'package:clone_shopping/features/shop/checkout/Controller/chckout_controller.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../common/widgets/successScreen/successScreen.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/models/UserMode/user_model.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/userRepository/user_controller.dart';
import '../../home/HomeScreen.dart';

class PaymentController extends GetxController{

  static PaymentController get instance => Get.find<PaymentController>();

  Rx<PaymentMethods> selectedPaymentMethod = PaymentMethods.upi.obs;

  void changePaymentMethod(PaymentMethods method){
    selectedPaymentMethod.value = method;
  }

  String displayPaymentMethod(PaymentMethods method){
    switch(method){
      case PaymentMethods.upi:
        return "Pay now online";
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

  void completePayment(int amount){
    try{
      final razorpay = Razorpay();
      UserModel user = Get.find<UserController>().user.value;
      final options = {
        "key " : "",
        "amount" : amount * 100,
        "name" : "Tappit",
        "description" : "credit purchase",
        "prefill" : {
          "contact" : user.phoneNumber,
          "email" : user.email,
        },
        "external" : {
          "wallets" : ["paytm"]
        }
      };

      razorpay.open(options);

      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    }catch(e){
      TLoaders.errorSnackBar(title: "Oh Snap",message: e.toString());
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
      try{
          final orderId = response.orderId;
          final paymentId = response.paymentId;
          final signature = response.signature;
         final controller = Get.put(CheckoutController());

          await controller.placeOrder(orderId!);


      }catch(e){
        TLoaders.errorSnackBar(title: "Oh Snap",message: e.toString());
      }
  }


  void _handlePaymentError(PaymentFailureResponse response){
    try{
      final code = response.code;
      final message = response.message;
      final error = response.error;
      TLoaders.errorSnackBar(title: "Oh Snap",message: message);
    }catch(e){
      TLoaders.errorSnackBar(title: "Oh Snap",message: e.toString());
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    try{
      final walletName = response.walletName;
      TLoaders.errorSnackBar(title: "Oh Snap",message: walletName);
    }catch(e){
      TLoaders.errorSnackBar(title: "Oh Snap",message: e.toString());
    }
  }

}