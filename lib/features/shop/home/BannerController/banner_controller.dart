import 'package:clone_shopping/features/shop/models/banner_model.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositries/BannerRepository/banner_repository.dart';

class BannerController extends GetxController{

  final pageIndex = 0.obs;
  final isLoading = true.obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(int index) {
    pageIndex.value = index;
  }

  Future<void> fetchBanners() async {

   try{
     isLoading.value = true;
     final banners = await BannerRepository.instance.fetchBanners();
     this.banners.value = banners;

   }catch(e){
     TLoaders.errorSnackBar(title: e.toString());
   }finally {
     isLoading.value = false;
   }
  }
}