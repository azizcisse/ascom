import 'package:get/get.dart';
import 'package:ascom/data/repositories/product/product_repository.dart';
import 'package:ascom/features/shop/models/brand_model.dart';
import 'package:ascom/features/shop/models/product_model.dart';
import 'package:ascom/utils/popups/loaders.dart';
import '../../../data/repositories/brands/brand_repository.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// -- Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      /// Show loader while loading brands
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Erreur!', message: e.toString());
    } finally {
      /// Stop Loader
      isLoading.value = false;
    }
  }

  /// -- Get Brands For Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Erreur!', message: e.toString());
      return [];
    }
  }

  /// -- Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Erreur!', message: e.toString());
      return [];
    }
  }
}
