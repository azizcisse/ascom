import 'package:flutter/material.dart';
import 'package:ascom/navigation_menu.dart';
import 'package:ascom/common/widgets/success_screen/success_screen.dart';
import 'package:ascom/data/repositories/authentication/authentication_repository.dart';
import 'package:ascom/utils/constants/enums.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import 'package:ascom/utils/popups/full_screen_loader.dart';
import 'package:ascom/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:ascom/features/shop/controllers/product/checkout_controller.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../personnalization/controllers/address_controller.dart';
import '../../../personnalization/models/order_model.dart';
import 'cart_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variabbles
  final cartController = CartController();
  final addressController = AddressController();
  final checkoutController = CheckoutController();
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      ALoaders.warningSnackBar(title: "Oh Erreur!", message: e.toString());
      return [];
    }
  }

  /// Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      /// Start Loader
      AFullScreenLoader.openLoadingDialog(
          "Traitement de votre commande", AImages.pencilAnimation);

      /// Get user Authentication Id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      ///  Add Details
      final order = OrderModel(
        /// Genrate a unique Id for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.processing,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,

        /// Set Date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      /// Save the Order to Firestore
      await orderRepository.saveOrder(order, userId);

      /// Update the cart status
      cartController.clearCart();

      /// Show Success Screen
      Get.off(
        () => SuccessScreen(
          image: AImages.docerAnimation,
          title: "Paiement Validé Avec Succès...",
          subTitle: "Votre Commande sera bientôt expédié!",
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      ALoaders.errorSnackBar(title: "Oh Erreur", message: e.toString());
    }
  }
}
