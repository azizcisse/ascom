// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validations.dart';
import '../../../controllers/signup/signup_controller.dart';
import 'terms_and_conditions_checkbox.dart';

class ASignupForm extends StatelessWidget {
  const ASignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          /// Prénom & Nom
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      AValidation.validateEmptyText("Votre Prénom", value),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: ATexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(width: ASizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      AValidation.validateEmptyText("Votre Nom", value),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: ATexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ASizes.spaceBtwInputFields),

          /// Nom d'Utilisateur
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                AValidation.validateEmptyText("Nom d'Utilisateur", value),
            expands: false,
            decoration: InputDecoration(
              labelText: ATexts.username,
              prefixIcon: Icon(Iconsax.user_add),
            ),
          ),
          SizedBox(height: ASizes.spaceBtwInputFields),

          /// Adresse Email
          TextFormField(
            controller: controller.email,
            validator: (value) => AValidation.validateEmail(value),
            expands: false,
            decoration: InputDecoration(
              labelText: ATexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          SizedBox(height: ASizes.spaceBtwInputFields),

          /// Numéro Téléphone
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => AValidation.validatePhoneNumber(value),
            expands: false,
            decoration: InputDecoration(
              labelText: ATexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          SizedBox(height: ASizes.spaceBtwInputFields),

          /// Mot de Passe
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => AValidation.validatePassword(value),
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: ATexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: ASizes.spaceBtwSections),

          /// Termes et Conditions de Vérification
          ATermsAndConditionCheckbox(),
          SizedBox(height: ASizes.spaceBtwSections),

          /// Button S'inscrire
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text(ATexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
