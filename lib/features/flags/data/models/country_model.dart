import 'dart:convert';
import 'package:flags_task/features/flags/domain/entities/country.dart';

List<CountryModel> countriesFromJson(String str) {
  return List<CountryModel>.from(json
      .decode(str)
      .map((countryJson) => CountryModel.fromJson(countryJson)));
}

String countriesToJson(List<CountryModel> countries) {
  return json
      .encode(List<dynamic>.from(countries.map((country) => country.toJson())));
}

class CountryModel extends Country {
  CountryModel(
      {required String name,
      required String cca3,
      required List<String> borders,
      required Map<String, String> languages,
      required String region,
      required String flagUrl})
      : super(
          name: name,
          cca3: cca3,
          borders: borders,
          languages: languages,
          region: region,
          flagUrl: flagUrl,
        );

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
        name: json["name"]["common"],
        cca3: json["cca3"],
        borders: json["borders"],
        languages: json["languages"],
        region: json["region"],
        flagUrl: json["flags"]["png"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {'common': name},
      'cca3': cca3,
      'borders': borders,
      'languages': languages,
      'region': region,
      'flags': {'png': flagUrl}
    };
  }
}
