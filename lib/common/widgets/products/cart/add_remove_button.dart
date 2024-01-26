import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/a_circular_icon.dart';

class AProductQuantityWithAddRemoveButton extends StatelessWidget {
  const AProductQuantityWithAddRemoveButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Add Remove Buttons
        ACircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ASizes.md,
          color: AHelperFunctions.isDarkMode(context)
              ? AColors.white
              : AColors.black,
          backgroundColor: AHelperFunctions.isDarkMode(context)
              ? AColors.darkerGrey
              : AColors.light,
          onPressed: remove,
        ),

        const SizedBox(width: ASizes.spaceBtwItems),
        Text(quantity.toString(),
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: ASizes.spaceBtwItems),

        /// Add Add Buttons
        ACircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ASizes.md,
          color: AColors.white,
          backgroundColor: AColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
