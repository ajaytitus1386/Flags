import 'package:flags_task/features/flags/data/db/flags_database.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/presentation/widgets/country_list_builder.dart';
import 'package:flags_task/features/flags/presentation/widgets/heading_card.dart';
import 'package:flags_task/features/flags/presentation/widgets/languages_list_builder.dart';
import 'package:flags_task/features/flags/presentation/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  final CountryModel country;
  const CountryPage({Key? key, required this.country}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  //TODO: move logic to domain
  List<CountryModel> countries = [];

  _getCountriesByBorders() async {
    if (widget.country.borders.first == "") {
      return null;
    }
    for (var border in widget.country.borders) {
      try {
        final result = await FlagsDatabase.db.readCountry(border);
        setState(() {
          countries.add(result);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getCountriesByBorders();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            const HeadingCard(heading: 'Languages Spoken'),
            LanguageListBuilder(languages: widget.country.languages),
            _buildBorderingHeading(countries),
            _buildBorderingCountriesList(countries),
          ],
        ),
        appBarTitle: widget.country.name);
  }
}

Widget _buildBorderingHeading(List<CountryModel> countries) {
  if (countries.isNotEmpty) {
    return const HeadingCard(heading: 'Bordering Countries');
  } else {
    return const SizedBox.shrink();
  }
}

Widget _buildBorderingCountriesList(List<CountryModel> countries) {
  if (countries.isNotEmpty) {
    return Expanded(child: CountryListBuilder(countries: countries));
  } else {
    return const SizedBox.shrink();
  }
}
