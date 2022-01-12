import 'package:flags_task/features/flags/data/db/flags_database.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flags_task/features/flags/presentation/widgets/country_list_builder.dart';
import 'package:flags_task/features/flags/presentation/widgets/nav_drawer_widget.dart';
import 'package:flutter/material.dart';

class RegionPage extends StatefulWidget {
  final String region;
  const RegionPage({Key? key, required this.region}) : super(key: key);

  @override
  _RegionPageState createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  List<CountryModel> countries = [];

  _getCountriesByRegion() async {
    final result = await FlagsDatabase.db.readCountriesByRegion(widget.region);
    setState(() {
      countries = result;
    });
    debugPrint(countries.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    _getCountriesByRegion();
    return Scaffold(
      drawer: const NavDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.region,
          style: buildHeadingCardTextStyle(),
        ),
        backgroundColor: primary,
      ),
      body: CountryListBuilder(countries: countries),
    );
  }
}
