import 'package:flutter/material.dart';
import 'package:ascom/features/shop/controllers/product/cart_controller.dart';
import 'package:ascom/common/widgets/custom_shapes/containers/a_rounded_container.dart';
import 'package:ascom/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../../utils/popups/loaders.dart';
import '../../controllers/product/order_controller.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_amount_section.dart';
import 'widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = APricingCalculator.calculateTotalPrice(subTotal, "XOF");

    final dark = AHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text("Vérification",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// -- Items In Cart
              const ACartItems(showAddRemoveButtons: false),
              const SizedBox(height: ASizes.defaultSpace),

              /// -- Coupon TextField
              const ACouponCode(),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// -- Billing Section
              ARoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(ASizes.md),
                backgroundColor: dark ? AColors.black : AColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    ABillingAmountSection(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    /// Payment Methods
                    ABillingPaymentSection(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    /// Address
                    ABillingAddressSection(),
                    SizedBox(height: ASizes.spaceBtwItems),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => ALoaders.warningSnackBar(
                    title: "Panier Vide",
                    message:
                        "Ajoutez des articles dans le panier pour continuer",
                  ),
          child: Text("Vérification $totalAmount"),
        ),
      ),
    );
  }
}
