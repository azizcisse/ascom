import 'package:flutter/material.dart';
import 'package:ascom/features/shop/controllers/product/cart_controller.dart';
import 'package:ascom/common/widgets/icons/a_circular_icon.dart';
import 'package:ascom/utils/constants/colors.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';

class ABottomAddToCart extends StatelessWidget {
  const ABottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = AHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ASizes.defaultSpace,
        vertical: ASizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? AColors.darkerGrey : AColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(ASizes.cardRadiusLg),
          topRight: Radius.circular(ASizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ACircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: AColors.darkerGrey,
                  width: 40,
                  height: 40,
                  color: AColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1
                      ? null
                      : controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: ASizes.spaceBtwItems),
                Text(controller.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(width: ASizes.spaceBtwItems),
                ACircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: AColors.darkerGrey,
                  width: 40,
                  height: 40,
                  color: AColors.black,
                  onPressed: () => controller.productQuantityInCart.value += 1,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(ASizes.md),
                backgroundColor: AColors.black,
                side: const BorderSide(color: AColors.black),
              ),
              child: const Text("Ajouter Au Panier"),
            ),
          ],
        ),
      ),
    );
  }
}
