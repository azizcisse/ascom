// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/controllers/all_products_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../products_cards/product_card_vertical.dart';

class AShortableProducts extends StatelessWidget {
  const AShortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    /// Initialize Controller for Managing Product Fetching
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.sort),
            ),
            value: controller.selectedSortOption.value,
            onChanged: (value) {},
            items: [
              "Nom Produit",
              "Plus Cher",
              "Moins Cher",
              "En Vente",
              "Plus Récents",
            ]
                .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                .toList()),
        SizedBox(height: ASizes.spaceBtwItems),

        /// Products
        Obx(
          () => AGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => AProductCartVertical(
              product: controller.products[index],
            ),
          ),
        ),
      ],
    );
  }
}
