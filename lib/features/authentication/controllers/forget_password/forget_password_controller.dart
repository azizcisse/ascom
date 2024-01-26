import 'package:ascom/data/repositories/authentication/authentication_repository.dart';
import 'package:ascom/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../screens/password_configuration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
          "Vous Vous Etes Connectés...", AImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show Success Screen
      ALoaders.successSnackBar(
          title: "Email Envoyé",
          message:
              "Lien email envoyé pour réinitialiser votre mot de passe.".tr);

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      /// Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: "Oh Erreur!", message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
          "Vous Vous Etes Connectés...", AImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show Success Screen
      ALoaders.successSnackBar(
          title: "Email Envoyé",
          message:
              "Lien email envoyé pour réinitialiser votre mot de passe.".tr);
    } catch (e) {
      /// Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: "Oh Erreur!", message: e.toString());
    }
  }
}
