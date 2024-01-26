import 'package:ascom/common/widgets/texts/section_heading.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/list_tiles/payment_tile.dart';
import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: AImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(ASizes.lg),
          child: Column(
            children: [
              const ASectionHeading(
                  title: "Choisir Méthode de Paiement",
                  showActionButton: false),
              const SizedBox(height: ASizes.spaceBtwSections),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paypal', image: AImages.paypal)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Google Pay', image: AImages.googlePay)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Apple Pay', image: AImages.applePay)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              APaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'VISA', image: AImages.visa)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Master Card', image: AImages.masterCard)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              APaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'Wave', image: AImages.wave)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Orange Money', image: AImages.orangemoney)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'E-Money', image: AImages.emoney)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const SizedBox(height: ASizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
