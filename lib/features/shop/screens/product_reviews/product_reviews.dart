// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/rating_progress_indicator.dart';
import 'widgets/user_review_card.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar:
          AAppBar(title: Text("Commentaires et Notes"), showBackArrow: true),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Les notes et les avis sont vérifiés et proviennent de personnes qui utilisent le même type d'appareil que vous."),
              SizedBox(height: ASizes.spaceBtwItems),

              /// Overall Product Ratings
              OverallProductRating(),

              ARatingBarIndicator(rating: 3.5),
              Text("12,661", style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: ASizes.spaceBtwSections),

              /// User Reviews List
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
