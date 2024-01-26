// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/features/personnalization/controllers/address_controller.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ABillingAddressSection extends StatelessWidget {
  const ABillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ASectionHeading(
          title: "Adresse de Livraison",
          buttonTitle: "Choisir",
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
        addressController.selectedAddress.value.id.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Liberté 6",
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: ASizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.grey, size: 16),
                      SizedBox(width: ASizes.spaceBtwItems),
                      Text("+221 78 635 78 00",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  SizedBox(height: ASizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Icon(Icons.location_history,
                          color: Colors.grey, size: 16),
                      SizedBox(width: ASizes.spaceBtwItems),
                      Expanded(
                        child: Text(
                          "Dakar / Sénégal, SN",
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Text("Selctionner Adresse",
                style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}
