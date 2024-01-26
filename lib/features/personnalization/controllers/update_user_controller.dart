// ignore_for_file: prefer_const_constructors
import 'package:ascom/features/personnalization/controllers/user_controller.dart';
import 'package:ascom/features/personnalization/screens/profile/profile.dart';
import 'package:ascom/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Init user data when Home Screen appears.
  @override
  onInit() {
    super.onInit();
    initializeNames();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  /// -- Email and Password signIn
  Future<void> updateUserName() async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
          "Nous mettons à jour vos informations...", AImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first name in the Firebase Firestore.
      Map<String, dynamic> name = {
        'Votre Prénom': firstName.text.trim(),
        'Votre Nom': lastName.text.trim()
      };
      await userRepository.updateSingleFiled(name);

      // Update the Rx User value.
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show Success Message
      ALoaders.successSnackBar(
          title: "Super!",
          message: "Votre Prénom et Nom a été modifié avec Succès...");

      // Move to Previous Screen
      Get.off(() => ProfileScreen());
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: "Oh Erreur!", message: e.toString());
    }
  }
}
