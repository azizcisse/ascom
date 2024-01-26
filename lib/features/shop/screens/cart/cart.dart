import 'package:ascom/common/widgets/loaders/animation_loader.dart';
import 'package:ascom/navigation_menu.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:ascom/features/shop/controllers/product/cart_controller.dart';
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/features/shop/screens/checkout/checkout.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text("Gestion Panier",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        /// Nothing Found Widget
        final emptyWidget = AAnimationLoaderWidget(
          text: "Whoops! Le Panier est Vide.",
          animation: AImages.cartAnimation,
          showAction: true,
          actionText: "Remplissons-le",
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(ASizes.defaultSpace),

              /// -- Items In Cart
              child: ACartItems(),
            ),
          );
        }
      }),

      /// Checkout Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(
                  () => Text(
                      "Vérification ${controller.totalCartPrice.value} FCFA"),
                ),
              ),
            ),
    );
  }
}
