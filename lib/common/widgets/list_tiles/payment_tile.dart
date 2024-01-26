import 'package:ascom/common/widgets/custom_shapes/containers/a_rounded_container.dart';
import 'package:ascom/features/shop/controllers/product/checkout_controller.dart';
import 'package:ascom/features/shop/models/payment_method_model.dart';
import 'package:ascom/utils/constants/colors.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class APaymentTile extends StatelessWidget {
  const APaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: ARoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: AHelperFunctions.isDarkMode(context)
            ? AColors.light
            : AColors.white,
        padding: const EdgeInsets.all(ASizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
