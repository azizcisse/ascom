// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/common/widgets/layouts/grid_layout.dart';
import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/features/shop/screens/all_products/brand_products.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/brands/brand_cart.dart';
import '../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../controllers/brand_controller.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: AAppBar(
        title: Text("Liste des Marques"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              ASectionHeading(title: "Marques", showActionButton: false),
              SizedBox(height: ASizes.spaceBtwItems),

              /// Brands
              Obx(() {
                if (brandController.isLoading.value) return ABrandsShimmer();

                if (brandController.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      "Aucune Donnée Trouvée",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  );
                }

                return AGridLayout(
                  itemCount: brandController.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final brand = brandController.allBrands[index];

                    return ABrandCard(
                      showBorder: true,
                      brand: brand,
                      onTap: () => Get.to(() => BrandProducts(brand: brand)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
