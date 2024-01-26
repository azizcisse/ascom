import 'package:flutter/material.dart';
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:ascom/utils/constants/sizes.dart';
import 'widgets/orders_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: AAppBar(
        title: Text("Liste de Mes Commandes",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(ASizes.defaultSpace),

        /// -- Orders
        child: AOrderListItems(),
      ),
    );
  }
}
