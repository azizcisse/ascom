// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/common/widgets/images/a_circular_image.dart';
import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';
import 'widgets/change_name.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text("Gestion Profil"),
      ),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    /// Profile Picture
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : AImages.userProfil;
                      return controller.imageUploading.value
                          ? AShimmerEffect(width: 80, height: 80, radius: 80)
                          : ACircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: Text("Changer Photo"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ASizes.spaceBtwItems / 2),
              Divider(),
              SizedBox(height: ASizes.spaceBtwItems),
              ASectionHeading(
                  title: "Information du Profil", showActionButton: false),
              SizedBox(height: ASizes.spaceBtwItems),
              AProfileMenu(
                title: "Prénom & Nom",
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => ChangeName()),
              ),
              AProfileMenu(
                title: "Nom d'Utilisateur",
                value: controller.user.value.username,
                onPressed: () {},
              ),
              SizedBox(height: ASizes.spaceBtwItems / 2),
              Divider(),
              SizedBox(height: ASizes.spaceBtwItems),
              ASectionHeading(
                  title: "Information Personnel", showActionButton: false),
              SizedBox(height: ASizes.spaceBtwItems),
              AProfileMenu(
                title: "Votre Numéro",
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () {},
              ),
              AProfileMenu(
                title: "E-mail",
                value: controller.user.value.email,
                icon: Iconsax.receipt,
                onPressed: () {},
              ),
              AProfileMenu(
                title: "Numéro Téléphone",
                value: controller.user.value.phoneNumber,
                icon: Iconsax.call,
                onPressed: () {},
              ),
              AProfileMenu(
                title: "Sexe",
                value: "Masculin",
                icon: Iconsax.user,
                onPressed: () {},
              ),
              AProfileMenu(
                title: "Date de Naissance",
                value: "20 Oct. 1994",
                icon: Iconsax.calendar,
                onPressed: () {},
              ),
              Divider(),
              SizedBox(height: ASizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: Text(
                    "Supprimer Compte",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
