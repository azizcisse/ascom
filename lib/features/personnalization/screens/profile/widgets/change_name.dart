// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/features/personnalization/controllers/update_user_controller.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:ascom/utils/constants/text_strings.dart';
import 'package:ascom/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      /// Custom Appbar
      appBar: AAppBar(
        showBackArrow: true,
        title: Text("Modification Prénom & Nom",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              "Utilisez votre vrai nom pour une vérification facile. Ce nom apparaîtra sur plusieurs pages.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: ASizes.spaceBtwSections),

            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        AValidation.validateEmptyText("Votre Prénom", value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: ATexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        AValidation.validateEmptyText("Votre Nom", value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: ATexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ASizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: Text("Enregistrer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
