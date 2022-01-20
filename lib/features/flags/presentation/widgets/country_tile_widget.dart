import 'package:flags_task/features/flags/domain/entities/country.dart';
import 'package:flags_task/features/flags/presentation/pages/country_page.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flutter/material.dart';

class CountryTile extends StatefulWidget {
  final bool alternateTile;
  final Country country;
  const CountryTile(
      {Key? key, required this.country, required this.alternateTile})
      : super(key: key);

  @override
  _CountryTileState createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CountryPage(country: widget.country)));
      },
      child: Container(
        decoration: _makeTileDecoration(widget.alternateTile),
        child: ListTile(
          // Flag
          leading: SizedBox(
            height: 60,
            width: 60,
            child: Image.network(
              widget.country.flagUrl,
            ),
          ),
          // Country Name
          title: Center(
            child: Text(
              widget.country.name,
              style: buildTileHeadingTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          // Country Capital
          subtitle: Center(
            child: Text(
              widget.country.capital,
              style: buildTileNormalTextStyle(),
            ),
          ),
        ),
      ),
    );
  }
}

BoxDecoration _makeTileDecoration(bool isAlternate) {
  BoxDecoration tileDecoration = BoxDecoration(
    color: isAlternate ? Colors.grey.shade200 : Colors.grey.shade100,
    border: const Border(
      bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.25), width: 0.75),
    ),
  );
  return tileDecoration;
}
