import 'package:ascom/utils/device/device_utility.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class ATabBar extends StatelessWidget implements PreferredSizeWidget {
  const ATabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = AHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? AColors.black : AColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: AColors.primary,
        labelColor: dark ? AColors.white : AColors.primary,
        unselectedLabelColor: AColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ADeviceUtils.getAppBarHeight());
}
