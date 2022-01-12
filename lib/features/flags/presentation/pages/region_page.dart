import 'package:flags_task/features/flags/data/db/flags_database.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/presentation/widgets/country_list_builder.dart';
import 'package:flags_task/features/flags/presentation/widgets/scaffold_wrapper.dart';
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
    return ScaffoldWrapper(
        child: CountryListBuilder(countries: countries),
        appBarTitle: widget.region);
  }
}
