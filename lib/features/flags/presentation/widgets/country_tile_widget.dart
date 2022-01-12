import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
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
    // Trim the square bracket ends
    String _trimCapital(String capital) {
      if (capital == "null") {
        return "";
      }

      var result = capital.replaceAll("[", "");
      result = result.replaceAll("]", "");
      return result;
    }

    return Container(
      decoration: tileDecoration,
      child: ListTile(
        leading: SizedBox(
          height: 60,
          width: 60,
          child: Image.network(
            widget.country.flagUrl,
          ),
        ),
        title: Center(
          child: Text(
            widget.country.name,
            style: buildTileHeadingTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
        subtitle: Center(
          child: Text(
            _trimCapital(widget.country.capital),
            style: buildTileNormalTextStyle(),
          ),
        ),
      ),
    );
  }
}

BoxDecoration tileDecoration = const BoxDecoration(
    border: Border(
        bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.25), width: 0.75)));
