// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:ascom/common/widgets/shimmers/shimmer.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AListTileShimmer extends StatelessWidget {
  const AListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: ASizes.spaceBtwItems),
            Column(
              children: [
                AShimmerEffect(width: 100, height: 15),
                SizedBox(width: ASizes.spaceBtwItems / 2),
                AShimmerEffect(width: 80, height: 12),
              ],
            )
          ],
        )
      ],
    );
  }
}
