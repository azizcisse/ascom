// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/widgets/login_signup/social_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                ATexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: ASizes.spaceBtwSections),

              /// Formulaire
              ASignupForm(),
              SizedBox(height: ASizes.spaceBtwSections),

              /// Divider
              AFormDivider(dividerText: ATexts.orsignUpWith.capitalize!),
              SizedBox(height: ASizes.spaceBtwSections),

              /// Social Buttons Footer
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
