// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'progress_indicator_and_rating.dart';

class OverallProductRating extends StatelessWidget {
  const OverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text("4.8", style: Theme.of(context).textTheme.displayLarge),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              ARatingProgessIndicator(text: '5', value: 1.0),
              ARatingProgessIndicator(text: '4', value: 0.8),
              ARatingProgessIndicator(text: '3', value: 0.6),
              ARatingProgessIndicator(text: '2', value: 0.4),
              ARatingProgessIndicator(text: '1', value: 0.2),
            ],
          ),
        ),
      ],
    );
  }
}
