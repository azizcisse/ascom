// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/common/widgets/icons/a_circular_icon.dart';
import 'package:ascom/common/widgets/layouts/grid_layout.dart';
import 'package:ascom/common/widgets/loaders/animation_loader.dart';
import 'package:ascom/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ascom/common/widgets/shimmers/vertical_chimmer_product.dart';
import 'package:ascom/features/shop/controllers/product/favourites_controller.dart';
import 'package:ascom/features/shop/screens/home/home.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import 'package:ascom/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;

    return Scaffold(
      appBar: AAppBar(
        title: Text("Liste Favoris",
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          ACircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(
              HomeScreen(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                future: controller.favoriteProducts(),
                builder: (context, snapshot) {
                  /// Nothing Found Widget
                  final emptyWidget = AAnimationLoaderWidget(
                    text: 'Whoops! La Liste des Favoris est Vide...',
                    animation: AImages.pencilAnimation,
                    showAction: true,
                    actionText: 'Ajouter Vos Favoris.',
                    onActionPressed: () => Get.offAll(() => NavigationMenu()),
                  );

                  const loader = AVerticalProductShimmer(itemCount: 6);
                  final widget = ACloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                    nothingFound: emptyWidget,
                  );
                  if (widget != null) return widget;

                  final products = snapshot.data!;

                  return AGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) => AProductCartVertical(
                      product: products[index],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
