// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:ascom/common/widgets/images/a_circular_image.dart';
import 'package:ascom/common/widgets/texts/a_brand_title_text_with_verified_icon.dart';
import 'package:ascom/common/widgets/texts/product_price_text.dart';
import 'package:ascom/features/shop/controllers/product/product_controller.dart';
import 'package:ascom/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/custom_shapes/containers/a_rounded_container.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';

class AProductMetaData extends StatelessWidget {
  const AProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final darkMode = AHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            ARoundedContainer(
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
            SizedBox(width: ASizes.spaceBtwItems),

            /// Price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              SizedBox(width: ASizes.spaceBtwItems),
            AProductPriceText(
              price: controller.getProductsPrice(product),
              isLarge: true,
            ),
          ],
        ),
        SizedBox(width: ASizes.spaceBtwItems / 1.5),

        /// Title
        AProductTitleText(title: product.title),
        SizedBox(width: ASizes.spaceBtwItems / 1.5),

        /// Stack Status
        Row(
          children: [
            AProductTitleText(title: "Status"),
            SizedBox(width: ASizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        SizedBox(width: ASizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            ACircularImage(
              isNetworkImage: true,
              image: product.brand != null ? product.brand!.image : '',
              width: 35,
              height: 35,
              overlayColor: darkMode ? AColors.white : AColors.black,
            ),
            ABrandTitleWithVerifiedIcon(
              title: product.brand != null ? product.brand!.name : '',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
