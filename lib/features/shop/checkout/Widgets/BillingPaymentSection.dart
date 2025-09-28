import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/common/widgets/texts/SectionHeading.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../Controller/paymen_controller.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();
    final dark = THelperFunctions.isDarkMode(context);
    List<PaymentMethods> paymentMethods = PaymentMethods.values;
    return Column(
      children: [
        SectionHeading(
          title: "Payment Method",
          buttonTitle: "change",
          onPressed: () {},
          showActionButton: true,
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 2),

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: paymentMethods.length,
          itemBuilder: (context, index) {
            final paymentMethod = paymentMethods[index];
            return Obx(
              () => InkWell(
                onTap: () {
                  controller.changePaymentMethod(paymentMethod);
                },
                child: Row(
                  children: [
                    Radio(
                      value: paymentMethod,
                      groupValue: controller.selectedPaymentMethod.value,
                      toggleable: true,
                      activeColor: TColors.primary,
                      onChanged: (value) {
                        controller.changePaymentMethod(value!);
                      },
                      // fillColor: ,,
                    ),
                    Text(
                      controller.displayPaymentMethod(paymentMethod),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Spacer(),
                    TRoundedContainer(
                      height: 35,
                      width: 60,
                      backgroundColor: dark ? TColors.dark : TColors.white,
                      padding: EdgeInsets.all(TSizes.sm),
                      child: Image(
                        image: AssetImage(
                          controller.displayPaymentMethodImage(paymentMethod),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
