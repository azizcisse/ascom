// ignore_for_file: prefer_const_constructors, prefer_null_aware_operators
import 'package:ascom/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ascom/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class AChoiseChip extends StatelessWidget {
  const AChoiseChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = AHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? AColors.white : null),
        avatar: isColor
            ? ACircularContainer(
                width: 50,
                height: 50,
                backgroundColor: AHelperFunctions.getColor(text)!)
            : null,
        labelPadding: isColor ? EdgeInsets.all(0) : null,

        /// Make Icon in the Center
        shape: isColor ? CircleBorder() : null,
        padding: isColor ? EdgeInsets.all(0) : null,
        backgroundColor: isColor ? AHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
