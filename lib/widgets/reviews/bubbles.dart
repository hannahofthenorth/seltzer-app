import 'package:flutter/material.dart';

import '../../bubble_icons.dart';

class Bubbles extends StatelessWidget {
  final double rating;
  final double size;

  Bubbles(this.rating, this.size);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (ctx, index) {
          if (rating >= index + 1) {
            return Icon(
              BubbleIcons.filled_bubbles,
              size: size,
            );
          } else if (rating < index + 1 && rating > index) {
            if (rating % 1 == 0.25) {
              return Icon(
                BubbleIcons.quarter_filled_bubbles,
                size: size,
              );
            } else if (rating % 1 == 0.5) {
              return Icon(
                BubbleIcons.half_filled_bubbles,
                size: size,
              );
            } else {
              return Icon(
                BubbleIcons.three_quarter_bubbles,
                size: size,
              );
            }
          } else {
            return Icon(
              BubbleIcons.empty_bubbles,
              size: size,
            );
          }
        });
  }
}
