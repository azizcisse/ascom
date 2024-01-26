import 'package:flutter/material.dart';
import 'package:ascom/common/widgets/images/a_rounded_image.dart';
import 'package:ascom/common/widgets/texts/product_title_text.dart';
import 'package:ascom/features/shop/controllers/product/product_controller.dart';
import 'package:ascom/features/shop/screens/product_details/product_detail.dart';
import 'package:ascom/utils/constants/enums.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/a_rounded_container.dart';
import '../../texts/a_brand_title_text_with_verified_icon.dart';
import '../../texts/product_price_text.dart';
import '../favourite_icon/favourite_icon.dart';
import 'add_to_cart_button.dart';

class AProductCartVertical extends StatelessWidget {
  const AProductCartVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = AHelperFunctions.isDarkMode(context);

    /// Container with side paddings, color, edges, radius and shadow.
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            product: product,
          )),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [AShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(ASizes.productImageRadius),
          color: dark ? AColors.darkerGrey : AColors.white,
        ),
        child: Column(
          children: [
            /// Thumbnail, WishList, Button, Discount, tag.
            ARoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(ASizes.sm),
              backgroundColor: dark ? AColors.dark : AColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Images
                  Center(
                    child: ARoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  /// -- Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: ARoundedContainer(
                        radius: ASizes.sm,
                        backgroundColor: AColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: ASizes.sm,
                          vertical: ASizes.xs,
                        ),
                        child: Text(
                          "$salePercentage%",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: AColors.black),
                        ),
                      ),
                    ),

                  /// -- Favourite IconButton
                  Positioned(
                    top: 0,
                    right: 0,
                    child: AFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwItems / 2),

            /// -- Détails
            Padding(
              padding: const EdgeInsets.only(left: ASizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AProductTitleText(
                    title: product.title,
                    smallSize: true,
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems / 2),
                  ABrandTitleWithVerifiedIcon(
                    title: product.brand!.name,
                  ),
                ],
              ),
            ),
            const Spacer(),

            /// Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price

                Flexible(
                  child: Column(
                    children: [
                      if (product.productType ==
                              ProductType.single.toString() &&
                          product.salePrice > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: ASizes.sm),
                          child: Text(
                            product.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),

                      /// Price, Show sale as main price if sale exist.
                      Padding(
                        padding: const EdgeInsets.only(left: ASizes.sm),
                        child: AProductPriceText(
                          price: controller.getProductsPrice(product),
                          isLarge: true,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Add to Cart Button
                ProductCartAddToCartButton(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
