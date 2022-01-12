import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flutter/material.dart';

class CountryTile extends StatefulWidget {
  final CountryModel country;
  const CountryTile({Key? key, required this.country}) : super(key: key);

  @override
  _CountryTileState createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.country.name),
    );
  }
}
