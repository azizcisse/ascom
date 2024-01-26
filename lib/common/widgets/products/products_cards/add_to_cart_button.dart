import 'package:flutter/material.dart';
import 'package:ascom/features/shop/controllers/product/cart_controller.dart';
import 'package:ascom/features/shop/models/product_model.dart';
import 'package:ascom/utils/constants/colors.dart';
import 'package:ascom/utils/constants/enums.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/screens/product_details/product_detail.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        /// If the product have variations then show the product Details for variation selection.
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          /// Else add product to the cart.
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);

        return Container(
          decoration: BoxDecoration(
            color: productQuantityInCart > 0 ? AColors.primary : AColors.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(ASizes.cardRadiusMd),
              bottomRight: Radius.circular(ASizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: ASizes.iconLg * 1.2,
            height: ASizes.iconLg * 1.2,
            child: Center(
              child: productQuantityInCart > 0
                  ? Text(
                      productQuantityInCart.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: AColors.white),
                    )
                  : const Icon(
                      Iconsax.add,
                      color: AColors.white,
                    ),
            ),
          ),
        );
      }),
    );
  }
}
