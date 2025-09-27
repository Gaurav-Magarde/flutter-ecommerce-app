import 'package:clone_shopping/common/widgets/shimmer/category_shimmer.dart';
import 'package:clone_shopping/features/shop/controllers/categoryController/category_controller.dart';
import 'package:clone_shopping/features/shop/subProducts/sub_products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../common/widgets/container/VerticalImageText.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(() {
      if (controller.isLoading.value) {
        return SizedBox(
          height: 82,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 8),
            separatorBuilder: (_, index) => const SizedBox(width: 10),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 9,
            itemBuilder: (context, index) {
              return CategoryShimmer();
            },
          ),
        );
      }

      if (controller.allCategory.isEmpty) {
        return SizedBox(
          height: 82,
          child: Center(
            child: Text(
              "No Featured Categories",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      }

      return SizedBox(
        height: 82,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.allCategory.length,
          itemBuilder: (context, index) {
            final category = controller.allCategory[index];
            return VerticalImageText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(const SubProductsScreen()),
            );
          },
        ),
      );
    });
  }
}
