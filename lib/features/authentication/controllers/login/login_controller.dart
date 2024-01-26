// ignore_for_file: unused_local_variable
import 'package:ascom/data/repositories/authentication/authentication_repository.dart';
import 'package:ascom/features/personnalization/controllers/user_controller.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import 'package:ascom/utils/helpers/network_manager.dart';
import 'package:ascom/utils/popups/full_screen_loader.dart';
import 'package:ascom/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSOWRD') ?? '';
    super.onInit();
  }

  /// -- Email and Password signIn
  Future<void> emailAndPasswordSignIn() async {
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
      if (!loginFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using EMAIL & Password Authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: "Oh Erreur!", message: e.toString());
    }
  }

  /// -- Google SignIn Authentication
  Future<void> googleSignIn() async {
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

      /// Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      /// Save user data
      await userController.saveUserRecord(userCredentials);

      /// Remove Loader
      AFullScreenLoader.stopLoading();
    } catch (e) {
      /// Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: "Oh Erreur!", message: e.toString());
    }
  }
}
