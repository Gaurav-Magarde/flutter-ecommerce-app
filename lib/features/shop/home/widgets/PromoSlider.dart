import 'package:carousel_slider/carousel_slider.dart';
import 'package:clone_shopping/common/widgets/shimmer/banner_shimmer.dart';
import 'package:clone_shopping/features/shop/home/BannerController/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/images/RoundedImage.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/TCircularContainer/TCircularContainer.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value) {
        return BannerShimmer();
      }

      if (controller.banners.isEmpty) {
        return const Center(child: Text("No Banners Found"));
      }

      return Column(
        children: [
          CarouselSlider(

            items: controller.banners
                .map(
                  (banner) => RoundedImage(
                    circularIndicator: false,
                    isCached: true,
                    isNetworkImage: true,
                    imageURL: banner.imageUrl,
                    onPressed: () => Get.toNamed(banner.targetScreen),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index),
              viewportFraction: 1,
              autoPlay: true,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < controller.banners.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TCircularContainer(
                    height: 4,
                    width: 20,
                    backgroundColor: controller.pageIndex.value == i
                        ? TColors.primary
                        : TColors.grey,
                  ),
                ),
            ],
          ),
        ],
      );
    });
  }
}
