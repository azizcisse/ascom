// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class AShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: AColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: AColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2),
  );
}
