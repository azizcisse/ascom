// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ascom/common/widgets/shimmers/shimmer.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ABoxesShimmer extends StatelessWidget {
  const ABoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AShimmerEffect(height: 100, width: 150),
            ),
            SizedBox(width: ASizes.spaceBtwItems),
            Expanded(
              child: AShimmerEffect(height: 100, width: 150),
            ),
            SizedBox(width: ASizes.spaceBtwItems),
            Expanded(
              child: AShimmerEffect(height: 100, width: 150),
            ),
          ],
        ),
      ],
    );
  }
}
