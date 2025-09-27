import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/common/widgets/successScreen/successScreen.dart';
import 'package:clone_shopping/features/personalization/Screens/Address/address_screen.dart';
import 'package:clone_shopping/features/shop/home/HomeScreen.dart';
import 'package:clone_shopping/utils/constants/image_strings.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../Cart/CuponCodeField.dart';
import '../Cart/cart_item.dart';
import 'Controller/chckout_controller.dart';
import 'Widgets/BillingAmount.dart';
import 'Widgets/BillingPaymentSection.dart';
import 'Widgets/billing_address_section.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(CheckoutController());
    return Scaffold(
      appBar: TAppBar(title: Text("Orders"), showBackArrow: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Items in cart
              CartItems(
                showBuyNowButton: false,
                showAddRemoveButtons: true,
                cartItems: controller.selectedCartItems,
              ),
              const SizedBox(height: TSizes.defaultSpace),

              ///Coupon code field
              CouponCodeField(),

              ///Billing Payment section
              TRoundedContainer(
                padding: EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.dark : TColors.white,
                child: Column(
                  children: [
                    PaymentAmount(),

                    ///Divider
                    const Divider(),

                    /// Payment Section
                    BillingPaymentSection(),

                    ///Billing Address
                    Obx(() {
                      final address = controller.selectedDeliveryAddress.value;
                      if (address.id.isEmpty) {
                        return BillingAddressSection(
                          onTap: () {
                            Get.to(() => const AddressScreen());
                            controller.fetchDeliveryAddress();
                          },
                        );
                      }
                      return BillingAddressSection(
                        address: address,
                        onTap: () async {
                          await Get.to(() => AddressScreen());
                          controller.fetchDeliveryAddress();
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace,
          vertical: TSizes.defaultSpace / 2,
        ),
        child: ElevatedButton(
          onPressed: () => Get.to(
            SuccessScreen(
              image: TImages.successfulPaymentIcon,
              title: "Payment Successful",
              subTitle: "ThankYou for shopping products .keep buying",
              onPressed: () => Get.to(const HomeScreen()),
            ),
          ),
          child: Text("Proceed to Payment"),
        ),
      ),
    );
  }
}
