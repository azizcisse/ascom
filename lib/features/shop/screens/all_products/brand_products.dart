// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/common/widgets/brands/brand_cart.dart';
import 'package:ascom/common/widgets/products/shortable/shortable_products.dart';
import 'package:ascom/common/widgets/shimmers/vertical_chimmer_product.dart';
import 'package:ascom/features/shop/controllers/brand_controller.dart';
import 'package:ascom/features/shop/models/brand_model.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:ascom/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: AAppBar(
        title: Text(brand.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              ABrandCard(showBorder: true, brand: brand),
              SizedBox(height: ASizes.spaceBtwSections),

              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    const loader = AVerticalProductShimmer();
                    final widget = ACloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    /// Record Brands
                    final brandProducts = snapshot.data!;

                    return AShortableProducts(
                      products: brandProducts,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
