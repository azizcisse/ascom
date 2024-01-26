// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/common/widgets/images/a_rounded_image.dart';
import 'package:ascom/common/widgets/products/products_cards/product_card_horizontal.dart';
import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/features/shop/controllers/category_controller.dart';
import 'package:ascom/features/shop/screens/all_products/all_products.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:ascom/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/shimmers/horizontal_product_shimmer.dart';
import '../models/category_model.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: AAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              ARoundedImage(
                width: double.infinity,
                imageUrl: AImages.banner4,
                applyImageRadius: true,
              ),
              SizedBox(height: ASizes.spaceBtwSections),

              /// Sub Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    const loader = AHorizontalProductShimmer();
                    final widget = ACloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    /// Record Found
                    final subCategories = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final subCategory = subCategories[index];

                        return FutureBuilder(
                            future: controller.getCategoryProdcuts(
                                categoryId: subCategory.id, limit: -1),
                            builder: (context, snapshot) {
                              /// Handle Loader, No Record, OR Error Message
                              const loader = AHorizontalProductShimmer();
                              final widget =
                                  ACloudHelperFunctions.checkMultiRecordState(
                                      snapshot: snapshot, loader: loader);
                              if (widget != null) return widget;

                              /// Record Found
                              final products = snapshot.data!;

                              return Column(
                                children: [
                                  /// Heading
                                  ASectionHeading(
                                    title: subCategory.name,
                                    onPressed: () => Get.to(
                                      () => AllProducts(
                                        title: subCategory.name,
                                        futureMethod:
                                            controller.getCategoryProdcuts(
                                                categoryId: subCategory.id,
                                                limit: -1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: ASizes.spaceBtwItems / 2),

                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                      itemCount: products.length,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: ASizes.spaceBtwItems),
                                      itemBuilder: (context, index) =>
                                          AProductCardHorizontal(
                                              product: products[index]),
                                    ),
                                  ),
                                  SizedBox(height: ASizes.spaceBtwSections),
                                ],
                              );
                            });
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
