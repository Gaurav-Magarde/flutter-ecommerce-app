import 'package:clone_shopping/data/repositries/categories/category_repository.dart';
import 'package:clone_shopping/features/shop/models/category_model.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
static CategoryController get instance => Get.find();

final _categoryRepository =  Get.put(CategoryRepository());
final isLoading = false.obs;
RxList<CategoryModel> allCategory= <CategoryModel>[].obs;
RxList<CategoryModel> featuredCategory = <CategoryModel>[].obs;

@override
  void onInit() {
  fetchAllCategories();
  super.onInit();

  }

  Future<void> fetchAllCategories() async {
  try {

  isLoading.value = true;

  final categories = await CategoryRepository.instance.getAllCategories();

  allCategory.assignAll(categories);

  featuredCategory.assignAll(allCategory.where((items)=> items.featured && items.parentId.isEmpty).take(8).toList());

  isLoading.value = false;

  }catch(e){
    TLoaders.errorSnackBar(title: "ohSnap",message: e.toString());
    isLoading.value = false;
  }
  }
}