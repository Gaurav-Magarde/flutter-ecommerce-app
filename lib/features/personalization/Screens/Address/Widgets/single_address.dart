import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';
import '../controller/address_controller.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.name,
    required this.phoneNo,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.id,
    this.onTap,
    required this.pinCode, this.onEdit, this.onRemove,
  });

  final String name;
  final String phoneNo;
  final String street;
  final String city;
  final String state;
  final String country;
  final String pinCode;
  final String id;
  final Function()? onTap;
  final Function()? onEdit;
  final Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: GestureDetector(
        onTap: onTap,
        child: Obx(() {
          final isSelected =
              Get.find<AddressController>().selectedAddressId.value == id;
          return TRoundedContainer(
            borderWidth: isSelected ? 2.5 : 1,
            borderColor: isSelected ? TColors.primary : TColors.darkGrey,
            showBorder: true,
            radius: 15,
            width: double.infinity,
            backgroundColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Selected circular container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? TColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: TColors.dark),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: TSizes.spaceBtwItems / 4),

                  ///Name
                  SizedBox(height: TSizes.spaceBtwItems / 4),

                  Text(phoneNo, maxLines: 1, overflow: TextOverflow.ellipsis),

                  SizedBox(height: TSizes.spaceBtwItems / 4),

                  Text("$street, $city, $state,"),
                  SizedBox(height: TSizes.spaceBtwItems / 4),

                  Text("Pincode : $pinCode"),
                  SizedBox(height: TSizes.spaceBtwItems / 4),

                  Text(country),

                  SizedBox(height: TSizes.spaceBtwItems / 2),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onEdit,
                          style: TextButton.styleFrom(
                              // padding: EdgeInsets.symmetric(vertical: 40)

                          ),
                          child: Text(
                            "Edit",
                            style: Theme.of(context).textTheme.labelLarge,

                          ),
                        ),
                      ),
                      SizedBox(width: TSizes.spaceBtwItems),
                      Expanded(
                        child: OutlinedButton(
                          style: TextButton.styleFrom(
                            // padding: EdgeInsets.symmetric(vertical: 40)
                          ),
                          onPressed: onRemove,
                          child: Text(
                            "Remove",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
