// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ALoginHeader extends StatelessWidget {
  const ALoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          width: double.infinity,
          height: 150,
          image: AssetImage(
            dark ? AImages.lightAppLogo : AImages.darkAppLogo,
          ),
        ),
        Text(ATexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: ASizes.md),
        Text(ATexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
