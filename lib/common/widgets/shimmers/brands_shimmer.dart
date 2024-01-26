// ignore_for_file: prefer_const_constructors
import 'package:ascom/common/widgets/layouts/grid_layout.dart';
import 'package:flutter/material.dart';
import 'shimmer.dart';

class ABrandsShimmer extends StatelessWidget {
  const ABrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return AGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => AShimmerEffect(height: 80, width: 300),
    );
  }
}
