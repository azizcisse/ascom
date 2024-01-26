// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:ascom/common/styles/spacing_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ASpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Toitle & Sub-Title
              ALoginHeader(),

              /// Form
              ALoginForm(),

              /// Divider
              AFormDivider(dividerText: ATexts.orsignInWith.capitalize!),
              SizedBox(height: ASizes.spaceBtwSections),

              /// Footer
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
