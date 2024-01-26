// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:ascom/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/cart_controller.dart';

class ABillingPaymentSection extends StatelessWidget {
  const ABillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        /// SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Prix :", style: Theme.of(context).textTheme.bodyMedium),
            Text("$subTotal FCFA",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: ASizes.spaceBtwItems / 2),

        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Frais de Livraison :",
                style: Theme.of(context).textTheme.bodyMedium),
            Text(
                "${APricingCalculator.calculateShippingCost(subTotal, 'XOF')} FCFA",
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: ASizes.spaceBtwItems / 2),

        /// Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Frais de Taxe :",
                style: Theme.of(context).textTheme.bodyMedium),
            Text("${APricingCalculator.calculateTax(subTotal, 'XOF')} FCFA",
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: ASizes.spaceBtwItems / 2),

        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Somme Total :",
                style: Theme.of(context).textTheme.bodyMedium),
            Text(
                "${APricingCalculator.calculateTotalPrice(subTotal, 'XOF')} FCFA",
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
