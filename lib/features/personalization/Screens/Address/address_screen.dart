import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/shimmer/address_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import 'Models/address_model.dart';
import 'Widgets/single_address.dart';
import 'controller/address_controller.dart';
import 'new_address_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key, this.onTap});

  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to( NewAddressScreen(address: AddressModel.empty(),)),
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body:Obx((){

        if(controller.isLoading.value) {
          return  AddressShimmer();
        }

        if(controller.addresses.isEmpty) {
          return Center(child: Text("No Addresses Found", style: Theme.of(context).textTheme.titleMedium,));
        }

        return Obx(
          ()=> ListView.builder(
            itemCount: controller.addresses.length,
            itemBuilder: (context, index) {
              final address = controller.addresses[index];
              return Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace/2),
                child: SingleAddress(

                  onTap: () async {
                    // AddressChangeSnackBar();
                    await controller.changeDefaultAddress(address: address);
                    controller.selectedAddressId.value = address.id;

                  } ,
                  pinCode: address.pinCode,
                  id: address.id,
                  name: address.name,
                  phoneNo: address.phone,
                  street: address.street,
                  city: address.city,
                  state: address.state,
                  country: address.country,
                  onEdit: (){
                    Get.to(()=>NewAddressScreen(address: address,));
                  },
                  onRemove: (){
                    controller.removeAddress(address.id);
                  },
                ),
              );
            },
          ),
        );
      })
    );
  }
}

