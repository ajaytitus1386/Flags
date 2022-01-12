import 'package:flags_task/features/flags/presentation/pages/region_page.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/responsive_size.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flags_task/features/flags/presentation/widgets/nav_drawer_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawerWidget(),
      appBar: AppBar(
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              SizedBox(
                height: 24,
              ),
              HeadingCard(
                heading: 'Please pick a region!',
              ),
              SizedBox(
                height: 24,
              ),
              RegionCard(region: "Asia"),
              SizedBox(
                height: 24,
              ),
              RegionCard(region: "Africa"),
              SizedBox(
                height: 24,
              ),
              RegionCard(region: "Europe"),
              SizedBox(
                height: 24,
              ),
              RegionCard(region: "Americas"),
              SizedBox(
                height: 24,
              ),
              RegionCard(region: "Oceania"),
            ],
          ),
        ),
      ),
    );
  }
}

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegionPage(region: region)));
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

class HeadingCard extends StatelessWidget {
  final String heading;
  const HeadingCard({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: cardDecoration,
      width: SizeConfig.cardWidth + 100,
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
