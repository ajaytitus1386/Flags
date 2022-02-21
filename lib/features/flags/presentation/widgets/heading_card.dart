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
      decoration: buildHeadingDecoration(primary),
      margin: const EdgeInsets.symmetric(horizontal: 35),
      width: double.infinity,
      height: SizeConfig.cardHeight,
      child: Center(
        child: Text(
          heading,
          style: buildHeadingCardTextStyle(),
        ),
      ),
    );
  }
}

BoxDecoration buildHeadingDecoration(Color bgColor) {
  return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.05),
          blurRadius: 15,
        )
      ]);
}
