// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/features/personnalization/screens/address/address.dart';
import 'package:ascom/features/shop/screens/order/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/list_tile/settings_menu_tile.dart';
import '../../../../common/widgets/list_tile/user_profile_tile.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            APrimaryHeaderContainer(
              child: Column(
                children: [
                  AAppBar(
                    title: Text(
                      "Compte",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: AColors.white),
                    ),
                  ),

                  /// -- User Profile Card
                  AUserProfileTile(
                      onPressed: () => Get.to(() => ProfileScreen())),
                  SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            ),

            /// -- Body
            Padding(
              padding: EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account Settings
                  ASectionHeading(
                    title: "Réglages Comptes",
                    showActionButton: false,
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),

                  ASettingsMenuTile(
                    onTap: () => Get.to(() => UserAddressScreen()),
                    icon: Iconsax.safe_home,
                    title: 'Mon Adresse',
                    subTitle: 'Définir l\'Adresse de Livraison des Achats',
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'Mon Panier',
                    subTitle:
                        'Ajouter, supprimer des produits et passer à la caisse',
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'Mes Commandes',
                    subTitle: 'Commandes en cours et terminées',
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Compte Bancaire',
                    subTitle:
                        'Retirer le solde sur un compte bancaire enregistré',
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'Mes Coupons',
                    subTitle: 'Liste de tous les bons de réduction',
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle:
                        'Définir n\'importe quel type de message de notification',
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Confidentialité du compte',
                    subTitle:
                        'Gérer l\'utilisation des données et les comptes connectés',
                  ),

                  /// -- App Settings
                  SizedBox(height: ASizes.spaceBtwSections),
                  ASectionHeading(
                    title: "Réglage Application",
                    showActionButton: false,
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),

                  ASettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Charger des Données',
                    subTitle:
                        'Téléchargez des données sur votre Cloud Firebase',
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocalisation',
                    subTitle:
                        'Obtenez des recommandations en fonction de l\'emplacement',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Mode Sans Echec',
                    subTitle:
                        'Le résultat de la recherche est sans danger pour tous les âges',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  ASettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'Qualité d\'image HD',
                    subTitle: 'Définir la qualité de l\'image à voir',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// -- Logout Button
                  SizedBox(height: ASizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: Text("Se Déconnecter"),
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
