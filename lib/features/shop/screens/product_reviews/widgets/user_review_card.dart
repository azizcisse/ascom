// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:ascom/common/widgets/custom_shapes/containers/a_rounded_container.dart';
import 'package:ascom/common/widgets/products/ratings/rating_indicator.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(AImages.userProfil),
                ),
                SizedBox(height: ASizes.spaceBtwItems),
                Text("Diatou Kamara",
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        SizedBox(height: ASizes.spaceBtwItems),

        /// Review
        Row(
          children: [
            ARatingBarIndicator(rating: 4),
            SizedBox(width: ASizes.spaceBtwItems),
            Text("01 Nov 2023", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(width: ASizes.spaceBtwItems),
        ReadMoreText(
          "Bien sûr, je serais ravi de vous aider avec des commentaires sur des chaussures ! Cependant, veuillez fournir plus d'informations sur les chaussures spécifiques sur lesquelles vous souhaitez des commentaires. Des détails tels que la marque, le modèle, le style, et vos préférences personnelles peuvent être utiles pour offrir un commentaire plus précis.",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: " Voir Moins",
          trimCollapsedText: " Voir Plus",
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AColors.primary),
        ),
        SizedBox(width: ASizes.spaceBtwItems),

        /// Company Review
        ARoundedContainer(
          backgroundColor: dark ? AColors.darkerGrey : AColors.grey,
          child: Padding(
            padding: EdgeInsets.all(ASizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ASCOM",
                        style: Theme.of(context).textTheme.titleMedium),
                    Text("02 Nov 2023",
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                SizedBox(width: ASizes.spaceBtwItems),
                ReadMoreText(
                  "Bien sûr, je serais ravi de vous aider avec des commentaires sur des chaussures ! Cependant, veuillez fournir plus d'informations sur les chaussures spécifiques sur lesquelles vous souhaitez des commentaires. Des détails tels que la marque, le modèle, le style, et vos préférences personnelles peuvent être utiles pour offrir un commentaire plus précis.",
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: " Voir Moins",
                  trimCollapsedText: " Voir Plus",
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AColors.primary),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AColors.primary),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: ASizes.spaceBtwSections),
      ],
    );
  }
}
