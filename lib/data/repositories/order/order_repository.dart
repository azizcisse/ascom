import 'package:ascom/data/repositories/authentication/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/personnalization/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /*-----------------------Functions----------------------*/

  /// Get all order related to current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw "Impossible de trouver les informations utilisateur. Réessayez dans quelques minutes.";
      }

      final result =
          await _db.collection("Users").doc(userId).collection("Orders").get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw "Une erreur s'est produite lors de la récupération des informations sur la commande. Réessayez plus tard!";
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw "Une erreur s'est produite lors de l'enregistrement des informations sur la commande. Réessayez plus tard!";
    }
  }
}
