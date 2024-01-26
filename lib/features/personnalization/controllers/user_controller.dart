// ignore_for_file: prefer_const_constructors
import 'package:ascom/data/repositories/authentication/authentication_repository.dart';
import 'package:ascom/data/repositories/user/user_repository.dart';
import 'package:ascom/features/authentication/screens/login/login.dart';
import 'package:ascom/features/personnalization/models/user_model.dart';
import 'package:ascom/features/personnalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:ascom/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      /// First Update Rx User and then check if user data is already stored. If not store new data.
      await fetchUserRecord();

      // If no record already stored.
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          /// Convert Name to First and Last Name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          /// Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          /// Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      ALoaders.warningSnackBar(
        title: "Informations non Enregistrées.",
        message:
            "Une Erreur s'est produite lors de l'enregistrement de vos informations. Vous pouvez encore enregistrer vos données dans votre profil.",
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(ASizes.md),
      title: "Supprimer le Compte",
      middleText:
          "Etes-Vous Sûr de Vouloir Supprimer définitivement votre Compte? Cette Action n'est pas Réversible et toutes vos données seront Supprimées définitivement. Merci!",
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ASizes.lg),
          child: Text("Supprimé"),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: Text("Annuler"),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      AFullScreenLoader.openLoadingDialog(
          "Suppression en Cours...", AImages.docerAnimation);

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth user
        if (provider == "google.com") {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          AFullScreenLoader.stopLoading();
          Get.offAll(() => LoginScreen());
        } else if (provider == "password") {
          AFullScreenLoader.stopLoading();
          Get.to(() => ReAuthLoginForm());
        }
      }
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.warningSnackBar(title: "Oh Erreurs!", message: e.toString());
    }
  }

  /// -- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      AFullScreenLoader.openLoadingDialog(
          "Traitement en Cours...", AImages.docerAnimation);

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      AFullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.warningSnackBar(title: "Oh Erreurs!", message: e.toString());
    }
  }

  /// Upload Profile Image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        // Upload Image
        final imageUrl =
            await userRepository.uploadImage("Users/Images/Profile", image);

        // Update User Image Record
        Map<String, dynamic> json = {'profilePicture': imageUrl};
        await userRepository.updateSingleFiled(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        ALoaders.successSnackBar(
            title: "Super!",
            message: "Votre  Photo de Profil a été modifié avec Succès...");
      }
    } catch (e) {
      ALoaders.warningSnackBar(title: "Oh Erreurs!", message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }
}
