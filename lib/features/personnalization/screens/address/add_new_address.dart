import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: const AAppBar(
        showBackArrow: true,
        title: Text("Ajout d'Une Nouvelle Adresse"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Form(
          key: controller.addressFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.name,
                validator: (value) =>
                    AValidation.validateEmptyText('Name', value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user), labelText: "Votre Nom"),
              ),
              const SizedBox(height: ASizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.phoneNumber,
                validator: AValidation.validatePhoneNumber,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: "Votre Téléphone"),
              ),
              const SizedBox(height: ASizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.street,
                      validator: (value) =>
                          AValidation.validateEmptyText('Street', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: "Votre Adresse"),
                    ),
                  ),
                  const SizedBox(width: ASizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.postalCode,
                      validator: (value) =>
                          AValidation.validateEmptyText('Postal Code', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: "Code Postal"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.city,
                      validator: (value) =>
                          AValidation.validateEmptyText('City', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: "Votre Ville"),
                    ),
                  ),
                  const SizedBox(width: ASizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.state,
                      validator: (value) =>
                          AValidation.validateEmptyText('State', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: "Votre Activité"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.country,
                validator: (value) =>
                    AValidation.validateEmptyText('Country', value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global), labelText: "Votre Pays"),
              ),
              const SizedBox(height: ASizes.spaceBtwInputFields),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.addNewAddresses(),
                  child: const Text("Enregistrer"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
