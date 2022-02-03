import 'package:flags_task/features/flags/domain/entities/country.dart';
import 'package:flags_task/features/flags/presentation/widgets/country_tile_widget.dart';
import 'package:flutter/material.dart';

class CountryListBuilder extends StatefulWidget {
  final List<Country> countries;
  const CountryListBuilder({Key? key, required this.countries})
      : super(key: key);

  @override
  _CountryListBuilderState createState() => _CountryListBuilderState();
}

class _CountryListBuilderState extends State<CountryListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.countries.length,
        itemBuilder: (context, index) {
          return CountryTile(
            country: widget.countries[index],
            alternateTile: _isAlternateTile(index),
          );
        });
  }
}

bool _isAlternateTile(int index) {
  if (index % 2 == 0) {
    return true;
  } else {
    return false;
  }
}
