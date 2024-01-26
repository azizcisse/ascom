// ignore_for_file: prefer_const_constructors
import 'package:ascom/common/widgets/shimmers/shimmer.dart';
import 'package:ascom/features/shop/models/brand_model.dart';
import 'package:ascom/features/shop/screens/all_products/brand_products.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/a_rounded_container.dart';
import 'brand_cart.dart';

class ABrandShowcase extends StatelessWidget {
  const ABrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: ARoundedContainer(
        showBorder: true,
        borderColor: AColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(ASizes.md),
        margin: EdgeInsets.only(bottom: ASizes.spaceBtwItems),
        child: Column(
          children: [
            /// Brand With Products Count
            ABrandCard(showBorder: true, brand: brand),
            SizedBox(height: ASizes.spaceBtwItems),

            /// Brand Top 3 Product Images
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: ARoundedContainer(
        height: 100,
        backgroundColor: AHelperFunctions.isDarkMode(context)
            ? AColors.darkerGrey
            : AColors.light,
        margin: EdgeInsets.only(right: ASizes.sm),
        padding: EdgeInsets.all(ASizes.md),
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, progress) =>
              AShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
