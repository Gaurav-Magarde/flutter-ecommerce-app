import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/features/personalization/Screens/Address/Models/address_model.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:clone_shopping/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'controller/address_controller.dart';

class NewAddressScreen extends StatelessWidget {
  const NewAddressScreen({super.key, required this.address});


  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final isEmpty = address.id.isEmpty;
    controller.setControllers(address);
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text(isEmpty ? "Add new Addresses" : "Edit Address")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [

                ///Name
                TextFormField(
                  controller: controller.nameController,
                  validator: (value){
                    return TValidator.validateEmptyText("First Name",value);

                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "Name",
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),
                ///Mobile No.
                TextFormField(
                  controller: controller.phoneController,
                  validator: (value){
                    return TValidator.validatePhoneNumber(value);

                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: "phone no.",
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),

                Row(

                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.streetController,
                        validator: (value){
                          return TValidator.validateEmptyText("Street",value);

                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: "Street",
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields,),
                    ///Mobile No.
                    Expanded(
                      child: TextFormField(
                        controller: controller.pinCodeController,
                        validator: (value){
                          return TValidator.validatePinCode(value);
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: "Pin Code",
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.cityController,
                        validator: (value){
                          return TValidator.validateEmptyText("City",value);
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: "city",
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields,),
                    ///Mobile No.
                    Expanded(
                      child: TextFormField(
                        controller: controller.stateController,
                        validator: (value){
                          return TValidator.validateEmptyText("State",value);
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: "state",
                        ),
                      ),
                    ),

                  ],
                ),


                const SizedBox(height: TSizes.spaceBtwInputFields,),
                TextFormField(

                  controller: controller.countryController,
                  validator: (value){
                     return TValidator.validateCountry(value);
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: "country",
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),
                SizedBox(child: ElevatedButton(onPressed: (){
                  isEmpty ? controller.addNewAddress() : controller.updateAddress(address.id);

                }, child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  child: Text(isEmpty ? "save" : "update"),
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
