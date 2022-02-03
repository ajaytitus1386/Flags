import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/responsive_size.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flutter/material.dart';

class HeadingCard extends StatelessWidget {
  final String heading;
  const HeadingCard({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: cardDecoration,
      width: SizeConfig.cardWidth + 80,
      height: SizeConfig.cardHeight,
      child: Card(
        color: primary,
        child: Center(
          child: Text(
            heading,
            style: buildHeadingCardTextStyle(),
          ),
        ),
      ),
    );
  }
}
