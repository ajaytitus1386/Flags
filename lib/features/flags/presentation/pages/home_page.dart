import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flags_task/features/flags/presentation/widgets/exit_dialog.dart';
import 'package:flags_task/features/flags/presentation/widgets/region_card.dart';
import 'package:flags_task/features/flags/presentation/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Controls the pop on exit when tapping back twice in quick succession
    return WillPopScope(
        onWillPop: () => showExitDialog(context),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            buildHeadingTitle(
              title: 'Pick a Region!',
            ),
            const SizedBox(
              height: 24,
            ),
            RegionCard(
              region: "Africa",
              regionColor: africaColor,
            ),
            const SizedBox(
              height: 24,
            ),
            RegionCard(
              region: "Americas",
              regionColor: americasColor,
            ),
            const SizedBox(
              height: 24,
            ),
            RegionCard(
              region: "Asia",
              regionColor: asiaColor,
            ),
            const SizedBox(
              height: 24,
            ),
            RegionCard(
              region: "Europe",
              regionColor: europeColor,
            ),
            const SizedBox(
              height: 24,
            ),
            RegionCard(
              region: "Oceania",
              regionColor: oceaniaColor,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHeadingTitle({required String title, String subtitle = ""}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        textAlign: TextAlign.left,
        style: buildHeadingTextStyle(),
      ),
      subtitle == ""
          ? const SizedBox.shrink()
          : Text(
              subtitle,
              textAlign: TextAlign.left,
              style: buildHeadingSubTextStyle(),
            )
    ],
  );
}
