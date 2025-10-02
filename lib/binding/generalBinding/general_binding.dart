import 'package:clone_shopping/data/repositries/dataRepositries/reposetry_authentication.dart';
import 'package:clone_shopping/data/repositries/userRepositries/user_Repositries.dart';
import 'package:clone_shopping/features/personalization/userRepository/user_controller.dart';
import 'package:clone_shopping/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

import '../../data/repositries/BannerRepository/banner_repository.dart';
import '../../features/shop/Repositries/brand_repository.dart';

class GeneralBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthenticationRepository());
    Get.lazyPut(()=>UserRepository());
    Get.lazyPut(()=>UserController());

    Get.lazyPut(()=>NetworkManager());
    Get.lazyPut(()=>BannerRepository());
    Get.lazyPut(()=>BrandRepository());


  }

}