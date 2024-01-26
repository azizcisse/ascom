import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/features/personnalization/screens/address/widgets/single_address.dart';
import 'package:ascom/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ascom/features/personnalization/models/address_model.dart';
import 'package:ascom/utils/helpers/network_manager.dart';
import 'package:ascom/utils/popups/full_screen_loader.dart';
import 'package:ascom/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  /// Fetch all user specific address
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      ALoaders.errorSnackBar(
          title: "Addresse Introuvable!", message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
      );

      //Clear the "selected" field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      //Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      //Set the "selected" field to the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      ALoaders.errorSnackBar(
          title: 'Erreur de Selection', message: e.toString());
    }
  }

  /// Add New Address
  Future addNewAddresses() async {
    try {
      /// Start Loading
      AFullScreenLoader.openLoadingDialog(
          "Enregistrment de l'Adresse...", AImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!addressFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      ///Save Address Data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
      );
      final id = await addressRepository.addAddress(address);

      /// Update Selected status
      address.id = id;
      selectedAddress(address);

      /// Remove Loader
      AFullScreenLoader.stopLoading();

      /// Show Success Message
      ALoaders.successSnackBar(
        title: 'Félicitations...',
        message: 'Votre Addresse a été enregistré avec Succès.',
      );

      /// Refresh Addresses Data
      refreshData.toggle();

      /// Reset Fields
      resetFormFields();

      /// Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      /// Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(
          title: 'Adresse Introuvable.', message: e.toString());
    }
  }

  /// Show Addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(ASizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ASectionHeading(title: "Selctionner Adresse", showActionButton: false),
            FutureBuilder(
              future: getAllUserAddresses(),
              builder: (_, snapshot) {
                /// Helper Function: Handle Loader, No Record, OR ERROR Message
                final response = ACloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => ASingleAdress(
                    address: snapshot.data![index],
                    onTap: () async {
                      selectedAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Function to Reset form Fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
