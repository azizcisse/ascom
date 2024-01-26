// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/custom_shapes/containers/a_rounded_container.dart';
import 'package:ascom/common/widgets/images/a_rounded_image.dart';
import 'package:ascom/common/widgets/texts/a_brand_title_text_with_verified_icon.dart';
import 'package:ascom/common/widgets/texts/product_price_text.dart';
import 'package:ascom/common/widgets/texts/product_title_text.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../favourite_icon/favourite_icon.dart';

class AProductCardHorizontal extends StatelessWidget {
  const AProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = AHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ASizes.productImageRadius),
        color: dark ? AColors.darkerGrey : AColors.softGrey,
      ),
      child: Row(
        children: [
          /// Thumbnail
          ARoundedContainer(
            height: 120,
            padding: EdgeInsets.all(ASizes.sm),
            backgroundColor: dark ? AColors.dark : AColors.light,
            child: Stack(
              children: [
                /// Thumbnail Image
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ARoundedImage(
                    imageUrl: product.thumbnail,
                    isNetworkImage: true,
                    applyImageRadius: true,
                  ),
                ),

                /// -- Sale Tag
                if (salePercentage != null)
                  Positioned(
                    top: 12,
                    child: ARoundedContainer(
                      radius: ASizes.sm,
                      backgroundColor: AColors.secondary.withOpacity(0.8),
                      padding: EdgeInsets.symmetric(
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

          /// Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: EdgeInsets.only(top: ASizes.sm, left: ASizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AProductTitleText(
                        title: product.title,
                        smallSize: true,
                      ),
                      SizedBox(height: ASizes.spaceBtwItems / 2),
                      ABrandTitleWithVerifiedIcon(title: product.brand!.name),
                    ],
                  ),
                  Spacer(),
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
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
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
                      Container(
                        decoration: BoxDecoration(
                          color: AColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ASizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(ASizes.productImageRadius),
                          ),
                        ),
                        child: SizedBox(
                          width: ASizes.iconLg * 1.2,
                          height: ASizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: AColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
