import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/product_model.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  /// Variables
  RxString selectedProductImage = ''.obs;

  /// Get All Images from product and variations
  List<String> getAllProductImages(ProductModel product) {
    /// Use Set to add unique images only
    Set<String> images = {};

    /// Load Thumbnail Image
    images.add(product.thumbnail);

    /// Assign Thumbnail as Selected Image
    selectedProductImage.value = product.thumbnail;

    /// Get All Images From The Product Model if Not Null
    if (product.images != null) {
      images.addAll(product.images!);
    }

    /// Get All Images From The Product Variations if not null
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }
    return images.toList();
  }

  /// Show Images Popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: ASizes.defaultSpace * 2,
                  horizontal: ASizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: image),
            ),
            const SizedBox(height: ASizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Fermer"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
