// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/shimmers/vertical_chimmer_product.dart';
import 'package:ascom/features/shop/screens/all_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/products_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            APrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  AHomeAppBar(),
                  SizedBox(height: ASizes.spaceBtwSections),

                  /// -- SearchBar
                  ASearchContainer(
                      text: "Rechercher n'importe quel produit..."),
                  SizedBox(height: ASizes.spaceBtwSections),

                  /// -- Catégories
                  Padding(
                    padding: EdgeInsets.only(left: ASizes.defaultSpace),
                    child: Column(
                      children: [
                        /// - Heading
                        ASectionHeading(
                          title: "Catégories Populaires",
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: ASizes.spaceBtwItems),

                        /// -- Catégories
                        AHomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  APromoSlider(),
                  SizedBox(height: ASizes.spaceBtwSections),

                  /// -- Heading
                  ASectionHeading(
                    title: "Produits Populaires",
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: "Produits Populaires",
                        futureMethod: controller.fetchAllProducts(),
                      ),
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),

                  /// Popular Products
                  Obx(() {
                    if (controller.isLoading.value)
                      return AVerticalProductShimmer();

                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text("Aucune Donnée Trouvée!",
                            style: Theme.of(context).textTheme.bodyMedium),
                      );
                    }

                    return AGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) => AProductCartVertical(
                        product: controller.featuredProducts[index],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
