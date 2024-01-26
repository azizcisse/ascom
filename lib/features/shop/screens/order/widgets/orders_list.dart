import 'package:ascom/common/widgets/loaders/animation_loader.dart';
import 'package:ascom/features/shop/controllers/product/order_controller.dart';
import 'package:ascom/navigation_menu.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import 'package:ascom/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/custom_shapes/containers/a_rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class AOrderListItems extends StatelessWidget {
  const AOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = AHelperFunctions.isDarkMode(context);
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          /// Nothing Found Widget
          final emptyWidget = AAnimationLoaderWidget(
            text: "Whoops! Pas Encore de Commandes",
            animation: AImages.docerAnimation,
            showAction: true,
            actionText: "Commandez Vos Produits!",
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          /// Helper Function: Handle Loader, No Record, OR ERROR Message.
          final response = ACloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          /// Congratulations Record found
          final orders = snapshot.data!;

          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: ASizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final order = orders[index];
                return ARoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(ASizes.md),
                  backgroundColor: dark ? AColors.dark : AColors.light,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// -- Row 1
                      Row(
                        children: [
                          /// 1 - Icon
                          const Icon(Iconsax.ship),
                          const SizedBox(width: ASizes.spaceBtwItems / 2),

                          /// 2 - Status & Date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderStatusText,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: AColors.primary,
                                          fontWeightDelta: 1),
                                ),
                                Text(
                                  order.formattedOrderDate,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),

                          /// 3 - Icon
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Iconsax.arrow_right_34,
                              size: ASizes.iconSm,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: ASizes.spaceBtwItems),

                      /// -- Row 2
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                /// 1 - Icon
                                const Icon(Iconsax.tag),
                                const SizedBox(width: ASizes.spaceBtwItems / 2),

                                /// 2 - Status & Date
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Commande",
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      Text(
                                        order.id,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                /// 1 - Icon
                                const Icon(Iconsax.ship),
                                const SizedBox(width: ASizes.spaceBtwItems / 2),

                                /// 2 - Status & Date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date de Livraison",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      Text(
                                        order.formattedDelideryDate,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
