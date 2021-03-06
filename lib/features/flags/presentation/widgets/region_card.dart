import 'package:flags_task/features/flags/presentation/animation/scale_page_route.dart';
import 'package:flags_task/features/flags/presentation/pages/region_page.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/responsive_size.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flutter/material.dart';

class RegionCard extends StatelessWidget {
  final String region;
  const RegionCard({
    Key? key,
    required this.region,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        // Generates the transition animation
        Navigator.push(context, scalePageBuilder(RegionPage(region: region)));
      },
      child: Container(
        decoration: cardDecoration,
        width: SizeConfig.cardWidth,
        height: SizeConfig.cardHeight,
        child: Card(
          color: secondary,
          child: Center(
            child: Text(
              region,
              style: buildRegionCardTextStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
