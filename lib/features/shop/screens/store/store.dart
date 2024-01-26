// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ascom/common/widgets/layouts/grid_layout.dart';
import 'package:ascom/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/features/shop/controllers/brand_controller.dart';
import 'package:ascom/features/shop/controllers/category_controller.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_cart.dart';
import '../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../brand/all_brands.dart';
import 'widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        /// -- AppBar
        appBar: AAppBar(
          title: Text(
            "Boutique",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            ACartCountIcon(),
          ],
        ),
        body: NestedScrollView(
          /// -- Header
          headerSliverBuilder: (_, innerBoxisScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: AHelperFunctions.isDarkMode(context)
                    ? AColors.black
                    : AColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(ASizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      /// -- Search Bar
                      SizedBox(height: ASizes.spaceBtwItems),
                      ASearchContainer(
                        text: "Rechercher dans la Boutique....",
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(height: ASizes.spaceBtwSections),

                      /// -- Featured Brands
                      ASectionHeading(
                        title: "Marques Vedettes",
                        onPressed: () => Get.to(() => AllBrandsScreen()),
                      ),
                      SizedBox(height: ASizes.spaceBtwItems / 1.5),

                      /// -- Brand Grid
                      Obx(() {
                        if (brandController.isLoading.value)
                          return ABrandsShimmer();

                        if (brandController.featuredBrands.isEmpty) {
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
                          itemCount: brandController.featuredBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            final brand = brandController.featuredBrands[index];
                            return ABrandCard(showBorder: true, brand: brand);
                          },
                        );
                      }),
                    ],
                  ),
                ),

                /// -- Tab
                bottom: ATabBar(
                  tabs: categories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
              children: categories
                  .map((category) => ACategoryTab(category: category))
                  .toList()),
        ),
      ),
    );
  }
}
