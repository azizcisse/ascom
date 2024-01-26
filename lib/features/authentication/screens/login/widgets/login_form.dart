// ignore_for_file: prefer_const_constructors
import 'package:ascom/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validations.dart';
import '../../password_configuration/forget_password.dart';
import '../../signup/signup.dart';

class ALoginForm extends StatelessWidget {
  const ALoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ASizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => AValidation.validateEmail(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: ATexts.email,
              ),
            ),
            SizedBox(height: ASizes.spaceBtwInputFields),
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
            SizedBox(height: ASizes.spaceBtwInputFields / 2),

            /// Se Souvenir de Moi et Mot de passe oublié
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Se Souvenir de Moi
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value,
                      ),
                    ),
                    Text(ATexts.rememberMe),
                  ],
                ),

                /// Mot de passe oublié
                TextButton(
                  onPressed: () => Get.to(() => ForgetPassword()),
                  child: Text(ATexts.forgetPassword),
                ),
              ],
            ),
            SizedBox(height: ASizes.spaceBtwSections),

            /// Button SeConnecter
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: Text(ATexts.signin),
              ),
            ),
            SizedBox(height: ASizes.spaceBtwSections),

            /// Button S'inscrire
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(
                  () => SignupScreen(),
                ),
                child: Text(ATexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
