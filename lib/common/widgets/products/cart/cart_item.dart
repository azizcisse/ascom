import 'package:flutter/material.dart';
import 'package:ascom/features/shop/models/cart_item_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/a_rounded_image.dart';
import '../../texts/a_brand_title_text_with_verified_icon.dart';
import '../../texts/product_title_text.dart';

class ACartItem extends StatelessWidget {
  const ACartItem({super.key, required this.cartItem});
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        ARoundedImage(
          isNetworkImage: true,
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(ASizes.sm),
          backgroundColor: AHelperFunctions.isDarkMode(context)
              ? AColors.darkerGrey
              : AColors.light,
        ),
        const SizedBox(width: ASizes.spaceBtwItems),

        /// Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ABrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child: AProductTitleText(title: cartItem.title, maxLines: 1),
              ),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map((e) => TextSpan(children: [
                            TextSpan(
                                text: ' ${e.key} ',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: ' ${e.value} ',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ]))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
