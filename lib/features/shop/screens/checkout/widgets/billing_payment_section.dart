import 'package:flutter/material.dart';
import 'package:ascom/common/widgets/custom_shapes/containers/a_rounded_container.dart';
import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/features/shop/controllers/product/checkout_controller.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class ABillingAmountSection extends StatelessWidget {
  const ABillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = AHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ASectionHeading(
          title: "Methode de Paiement",
          buttonTitle: "Choisir",
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: ASizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              ARoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? AColors.light : AColors.white,
                padding: const EdgeInsets.all(ASizes.sm),
                child: Image(
                  image:
                      AssetImage(controller.selectedPaymentMethod.value.image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
