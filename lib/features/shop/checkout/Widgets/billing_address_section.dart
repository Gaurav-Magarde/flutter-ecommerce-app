import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/texts/SectionHeading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personalization/Screens/Address/Models/address_model.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key, this.onTap, this.address});

  final AddressModel? address;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: "Delivery Address",
          buttonTitle: (address != null) ? "change" : "Add address",
          onPressed: onTap,
          showActionButton: true,
        ),

        if (address != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Text(
                address!.name,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              Row(
                children: [
                  const Icon(Icons.phone, color: TColors.grey, size: 16),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Text(
                    address!.phone,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems / 2),

              Row(
                children: [
                  const Icon(
                    Icons.location_history,
                    color: TColors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Text(
                    "${address!.street}, ${address!.city}, ${address!.state}, ${address!.country},\n ${address!.pinCode}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
