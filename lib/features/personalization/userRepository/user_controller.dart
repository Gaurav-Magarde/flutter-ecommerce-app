import 'package:clone_shopping/data/repositries/userRepositries/user_Repositries.dart';
import 'package:clone_shopping/utils/models/UserMode/user_model.dart';
import 'package:clone_shopping/utils/popups/full_screen_loader.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController{

  static UserController get instance => Get.find<UserController>();


  Rx<UserModel> user = UserModel.empty().obs;
  RxBool isUserLoading = false.obs;

  @override
  void onInit(){
    fetchUserRecord();
    super.onInit();

  }

  void clear() {
    user(UserModel.empty());
    isUserLoading.value = false;
  }


  Future<void> saveUserRecord(UserCredential ? userCredential) async {
    isUserLoading = true.obs;

    await fetchUserRecord();

    if(user.value.id.isEmpty){
      if (userCredential != null) {
        final fullName = UserModel.nameParts(
            userCredential.user!.displayName ?? " ");
        final userName = UserModel.generateUsername(
            userCredential.user!.displayName ?? " ");

        final user = UserModel(id: userCredential.user!.uid,
            email: userCredential.user!.email ?? " ",
            username: userName,
            firstName: fullName[0],
            lastName: fullName[1],
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            profilePicture: ""
        );

        await UserRepository.instance.saveUserRecord(user);
      } else {
        TLoaders.errorSnackBar(title: "ohSnap", message: " user not found");
      }
    }

    isUserLoading = false.obs;


  }


  Future<void> fetchUserRecord() async {

    try{
      isUserLoading = true.obs;
      final currentUser = await UserRepository.instance.fetchUserRecord();
      user.value = currentUser;
    }catch(e){
    user(UserModel.empty());
    TLoaders.errorSnackBar(title: "oh Snap",message: "Error Fetching Details");
    }finally{
      isUserLoading = false.obs;
    }
  }


  Future<void> updateOneField(Map<String, dynamic> json) async {

    try{
      await UserRepository.instance.updateSingleUserRecord(json);

    }catch(e){
      user(UserModel.empty());
      // TLoaders.errorSnackBar(title: "oh Snap",message: "Error Fetching Details");
    }
  }

  Future<void> uploadProfilePicture() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      TFullScreenLoader.openLoadingDialog("Saving your profile picture",
          "assets/images/animations/cloud-uploading-animation.json");
      if (image != null) {
        user.value.profilePicture = image.path;
        final  url = await UserRepository.instance.changeProfilePicture("personal/profile/picture",image);
        await updateOneField({"ProfilePicture": url});
      }else{
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "Oh snap",message: "Your profile picture has not been changed");
        return;
      }

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "Successful",message: "Your Profile picture has been successfully changed");
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh snap",message: e.toString());
    }
  }

}
