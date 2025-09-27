import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../../utils/popups/loaders.dart';
import '../Models/address_model.dart';
import '../Repository/addresses_repository.dart';

class AddressController extends GetxController {

  static AddressController get instance => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  RxList<AddressModel> addresses = <AddressModel>[].obs;
  RxBool isLoading = false.obs;

  RxString selectedAddressId = "".obs;

  @override
  void onInit() {
    Get.put(AddressRepository());
    fetchAddresses();
    super.onInit();
  }

  /// Fetch all the address whenever the address screen is opened
  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;
      final list = await Get.find<AddressRepository>().fetchAddresses();
      addresses.assignAll(list);

      final data = await Get.find<AddressRepository>().fetchDefaultAddress();
      if(data != null) {

        selectedAddressId.value = data.id;
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setControllers(AddressModel address) {
    nameController.text = address.name;
    phoneController.text = address.phone;
    streetController.text = address.street;
    cityController.text = address.city;
    stateController.text = address.state;
    countryController.text = address.country;
    pinCodeController.text = address.pinCode;
  }

  /// Add new address to firebase and also to the list
  Future<void> addNewAddress() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      TFullScreenLoader.openLoadingDialog("Adding Address", "assets/images/animations/98783-packaging-in-progress.json");

      final address = AddressModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text,
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
        pinCode: pinCodeController.text,
        phone: phoneController.text,
      );
      await Get.find<AddressRepository>().addNewAddress(address: address, isDefault: addresses.isEmpty);
      if(addresses.isEmpty) selectedAddressId.value = address.id;
      addresses.add(address);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: "Success", message: "Address Added Successfully");
    } catch (e) {

      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Change default address to firebase and into current
  Future<void> changeDefaultAddress({required AddressModel address}) async {
    try {
      if(selectedAddressId.value == address.id) return;

      isLoading.value = true;
      TFullScreenLoader.openLoadingDialog("Changing Address", "assets/images/animations/98783-packaging-in-progress.json");
      await Get.find<AddressRepository>().changeDefaultAddress(
          address: address);
      selectedAddressId.value = address.id;
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh snap!", message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  /// Update the existing address
  Future<void> updateAddress(String id) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      TFullScreenLoader.openLoadingDialog("updating Address", "assets/images/animations/98783-packaging-in-progress.json");

      final address = AddressModel(
        id: id,
        name: nameController.text,
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
        pinCode: pinCodeController.text,
        phone: phoneController.text,
      );
      await Get.find<AddressRepository>().updateAddress(address: address);
      TFullScreenLoader.stopLoading();
      
      addresses.removeWhere((item)=> item.id == id);
      addresses.add(address);
      TLoaders.successSnackBar(
          title: "Success", message: "Address Added Successfully");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> removeAddress(String id) async {
    try{
      isLoading.value = true;
      if(id == selectedAddressId.value){
        TLoaders.warningSnackBar(title: "Cannot Removed" , message: "Default Address cannot be removed,Please make another default address");

        return;
      }

      TFullScreenLoader.openLoadingDialog("Removing Address", "assets/images/animations/98783-packaging-in-progress.json");
      await Get.find<AddressRepository>().removeAddress(id: id);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "Address Removed", message: "Address Removed Successfully");
      addresses.removeWhere((item)=> item.id == id);
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh snap!", message: e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }

}
