// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ascom/common/widgets/custom_shapes/containers/a_rounded_container.dart';
import 'package:ascom/features/personnalization/controllers/address_controller.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../models/address_model.dart';

class ASingleAdress extends StatelessWidget {
  const ASingleAdress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = AHelperFunctions.isDarkMode(context);

    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;

        return InkWell(
          onTap: onTap,
          child: ARoundedContainer(
            width: double.infinity,
            padding: EdgeInsets.all(ASizes.md),
            showBorder: true,
            backgroundColor: selectedAddress
                ? AColors.primary.withOpacity(0.5)
                : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : dark
                    ? AColors.darkerGrey
                    : AColors.grey,
            margin: EdgeInsets.only(bottom: ASizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? dark
                            ? AColors.light
                            : AColors.dark
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: ASizes.sm / 2),
                    Text(
                      address.formattedPhoneNo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ASizes.sm / 2),
                    Text(
                      address.toString(),
                      softWrap: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
