// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/common/widgets/shimmers/vertical_chimmer_product.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:ascom/utils/helpers/cloud_helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/products/shortable/shortable_products.dart';
import '../../controllers/all_products_controller.dart';
import '../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    /// Initialize Controller for Managing Product Fetching
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: AAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                /// Check the state of the FutureBuilder snapshot
                const loader = AVerticalProductShimmer();
                final widget = ACloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);

                /// Return appropriate widget based on snapshot state
                if (widget != null) return widget;

                /// Products Found!
                final products = snapshot.data!;

                return AShortableProducts(products: products);
              }),
        ),
      ),
    );
  }
}
