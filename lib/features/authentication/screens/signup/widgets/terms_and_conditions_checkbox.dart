// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/signup/signup_controller.dart';

class ATermsAndConditionCheckbox extends StatelessWidget {
  const ATermsAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;

    final dark = AHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value,
            ),
          ),
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: ATexts.iAgreeTo,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: ATexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? AColors.white : AColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? AColors.white : AColors.primary,
                    ),
              ),
              TextSpan(
                text: ATexts.and,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: ATexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? AColors.white : AColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? AColors.white : AColors.primary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
