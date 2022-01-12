import 'package:flags_task/features/flags/presentation/animation/scale_page_route.dart';
import 'package:flags_task/features/flags/presentation/pages/region_page.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/responsive_size.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flags_task/features/flags/presentation/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime firstBackPress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final timeDiff = DateTime.now().difference(firstBackPress);
          final isReadyToExit = timeDiff >= const Duration(seconds: 3);
          firstBackPress = DateTime.now();

          if (isReadyToExit) {
            Fluttertoast.showToast(msg: 'Tap back again to exit');
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: const ScaffoldWrapper(
          child: HomeBody(),
          appBarTitle: "",
        ));
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 24,
            ),
            HeadingCard(
              heading: 'Pick a region!',
            ),
            SizedBox(
              height: 24,
            ),
            RegionCard(region: "Africa"),
            SizedBox(
              height: 24,
            ),
            RegionCard(region: "Americas"),
            SizedBox(
              height: 24,
            ),
            RegionCard(region: "Asia"),
            SizedBox(
              height: 24,
            ),
            RegionCard(region: "Europe"),
            SizedBox(
              height: 24,
            ),
            RegionCard(region: "Oceania"),
          ],
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
