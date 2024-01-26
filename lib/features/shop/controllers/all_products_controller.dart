import 'package:get/get.dart';
import 'package:ascom/data/repositories/product/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/popups/loaders.dart';
import '../models/product_model.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Nom Produit'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final products = await repository.fetchProductsByQuery(query);

      return products;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Erreur!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Nom Produit':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Plus Cher':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Moins Cher':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Plus Récents':
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      case 'En Vente':
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      default:

        /// Default sorting option: Name
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    /// Assign products to the 'products' List
    this.products.assignAll(products);
    sortProducts('Nom Produit');
  }
}
