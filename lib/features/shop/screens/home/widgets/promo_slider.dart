// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/shimmers/shimmer.dart';
import 'package:ascom/features/shop/controllers/banner_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/a_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class APromoSlider extends StatelessWidget {
  const APromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      // Loader
      if (controller.isLoading.value) {
        return AShimmerEffect(width: double.infinity, height: 190);
      }

      // No Data Found
      if (controller.banners.isEmpty) {
        return Center(
          child: Text("Aucune Donnée Disponible!"),
        );
      } else {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
              ),
              items: controller.banners
                  .map((banner) => ARoundedImage(
                        imageUrl: banner.imageUrl,
                        isNetworkImage: true,
                        onPressed: () => Get.toNamed(banner.targetScreen),
                      ))
                  .toList(),
            ),
            SizedBox(height: ASizes.spaceBtwItems),
            Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    ACircularContainer(
                      margin: EdgeInsets.only(right: 10),
                      width: 20,
                      height: 4,
                      backgroundColor:
                          controller.carouselCurrentIndex.value == i
                              ? AColors.primary
                              : AColors.grey,
                    ),
                ],
              ),
            ),
          ],
        );
      }
    });
  }
}
