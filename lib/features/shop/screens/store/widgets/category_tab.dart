// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/features/shop/controllers/category_controller.dart';
import 'package:ascom/features/shop/models/category_model.dart';
import 'package:ascom/features/shop/screens/all_products/all_products.dart';
import 'package:ascom/features/shop/screens/store/widgets/category_brands.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/products_cards/product_card_vertical.dart';
import '../../../../../common/widgets/shimmers/vertical_chimmer_product.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';

class ACategoryTab extends StatelessWidget {
  const ACategoryTab({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              CategroyBrands(category: category),
              SizedBox(height: ASizes.spaceBtwItems),

              /// -- Products

              FutureBuilder(
                  future:
                      controller.getCategoryProdcuts(categoryId: category.id),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message

                    final response =
                        ACloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: AVerticalProductShimmer(),
                    );
                    if (response != null) return response;

                    /// Record Brands
                    final products = snapshot.data!;

                    return Column(
                      children: [
                        ASectionHeading(
                          title: "Vous Pourriez Aimer",
                          onPressed: () => Get.to(
                            AllProducts(
                              title: category.name,
                              futureMethod: controller.getCategoryProdcuts(
                                  categoryId: category.id, limit: -1),
                            ),
                          ),
                        ),
                        SizedBox(height: ASizes.spaceBtwItems),
                        AGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => AProductCartVertical(
                            product: products[index],
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
