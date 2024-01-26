// ignore_for_file: prefer_const_constructors

import 'package:ascom/common/widgets/brands/brand_show_case.dart';
import 'package:ascom/features/shop/controllers/brand_controller.dart';
import 'package:ascom/features/shop/models/category_model.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:ascom/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/shimmers/boxes_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';

class CategroyBrands extends StatelessWidget {
  const CategroyBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          /// Handle Loader, No Record, OR Error Message
          const loader = Column(
            children: [
              AListTileShimmer(),
              SizedBox(height: ASizes.spaceBtwItems),
              ABoxesShimmer(),
              SizedBox(height: ASizes.spaceBtwItems),
            ],
          );
          final widget = ACloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          /// Record Found!
          final brands = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index) {
              final brand = brands[index];
              return FutureBuilder(
                  future:
                      controller.getBrandProducts(brandId: brand.id, limit: 3),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    final widget = ACloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    /// Record Found!
                    final products = snapshot.data!;
                    return ABrandShowcase(
                      images: products.map((e) => e.thumbnail).toList(),
                      brand: brand,
                    );
                  });
            },
          );
        });
  }
}
