import 'package:flags_task/features/flags/presentation/widgets/exit_dialog.dart';
import 'package:flags_task/features/flags/presentation/widgets/heading_card.dart';
import 'package:flags_task/features/flags/presentation/widgets/region_card.dart';
import 'package:flags_task/features/flags/presentation/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime firstBackPress = DateTime.now();
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
