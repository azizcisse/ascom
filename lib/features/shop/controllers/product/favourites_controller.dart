import 'package:get/get.dart';
import 'dart:convert';
import 'package:ascom/data/repositories/product/product_repository.dart';
import 'package:ascom/features/shop/models/product_model.dart';
import 'package:ascom/utils/local_storage/storage_utility.dart';
import 'package:ascom/utils/popups/loaders.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  /// Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    initFavourites();
    super.onInit();
  }

  /// Method to initialize favorites by reading from storage
  Future<void> initFavourites() async {
    final json = ALocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String prodcutId) {
    return favorites[prodcutId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      ALoaders.customToast(message: "Le Produit a été ajouté à vos Favoris.");
    } else {
      ALocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      ALoaders.customToast(
          message: "Le Produit a été supprimé de vos Favoris.");
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    ALocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance
        .getFavouriteProducts(favorites.keys.toList());
  }
}
