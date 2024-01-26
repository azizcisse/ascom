import 'package:flutter/material.dart';
import 'package:ascom/common/widgets/custom_shapes/containers/a_rounded_container.dart';
import 'package:ascom/common/widgets/texts/product_price_text.dart';
import 'package:ascom/common/widgets/texts/product_title_text.dart';
import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/features/shop/controllers/product/variation_controller.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/chips/choise_chip.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/product_model.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = AHelperFunctions.isDarkMode(context);
    return Obx(
      () => Column(
        children: [
          /// -- Selected Attribute Pricing & Description
          /// Display variation price and stock when some variation is selected
          if (controller.selectedVariation.value.id.isNotEmpty)
            ARoundedContainer(
              padding: const EdgeInsets.all(ASizes.md),
              backgroundColor: dark ? AColors.darkerGrey : AColors.grey,
              child: Column(
                children: [
                  /// Title, Price and Stock Status
                  Row(
                    children: [
                      const ASectionHeading(
                          title: "Variation", showActionButton: false),
                      const SizedBox(width: ASizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const AProductTitleText(
                                title: "Prix : ",
                                smallSize: true,
                              ),

                              /// Actual Price
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  controller.getVariationPrice(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              const SizedBox(width: ASizes.spaceBtwItems),

                              /// Sale Price
                              AProductPriceText(
                                price: controller.getVariationPrice(),
                              ),
                            ],
                          ),

                          /// Stock
                          Row(
                            children: [
                              const AProductTitleText(
                                title: "Stock : ",
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Variation Description
                  AProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(height: ASizes.spaceBtwItems),

          /// -- Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ASectionHeading(
                          title: attribute.name ?? '', showActionButton: false),
                      const SizedBox(width: ASizes.spaceBtwItems / 2),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map((attributeValue) {
                            final isSelected =
                                controller.selectedAttributes[attribute.name] ==
                                    attributeValue;
                            final available = controller
                                .getAttributesAvailabilityInVariation(
                                    product.productVariations!, attribute.name!)
                                .contains(attributeValue);

                            return AChoiseChip(
                              text: attributeValue,
                              selected: isSelected,
                              onSelected: available
                                  ? (selected) {
                                      if (selected && available) {
                                        controller.onAttributeSelected(
                                            product,
                                            attribute.name ?? '',
                                            attributeValue);
                                      }
                                    }
                                  : null,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
