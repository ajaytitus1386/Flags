import 'dart:convert';

/// Converts the response json string into List of ```CountryModel``` objects
List<CountryModel> countriesFromJson(String str) {
  return List<CountryModel>.from(json
      .decode(str)
      .map((countryJson) => CountryModel.fromApiJson(countryJson)));
}

/// Converts List of ```CountryModel``` into json string
String countriesToJson(List<CountryModel> countries) {
  return json
      .encode(List<dynamic>.from(countries.map((country) => country.toJson())));
}

class CountryModel {
  final String name;
  final String cca3;
  final String capital;
  final String region;
  final String flagUrl;

  CountryModel({
    required this.name,
    required this.cca3,
    required this.capital,
    required this.region,
    required this.flagUrl,
  }) : super();

  /// Specifically converts json from given API endpoint to ```CountryModel```
  factory CountryModel.fromApiJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json["name"]["common"] as String,
      cca3: json["cca3"] as String,
      capital: json["capital"].toString(),
      region: json["region"] as String,
      flagUrl: json["flags"]["png"] as String,
    );
  }

  /// Converts json as stored in Database back to ```CountryModel```
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json["name"] as String,
      cca3: json["cca3"] as String,
      capital: json["capital"] as String,
      region: json["region"] as String,
      flagUrl: json["flag_url"] as String,
    );
  }

  /// Returns a json object from ```CountryModel```
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cca3': cca3,
      'capital': capital,
      'region': region,
      'flagUrl': flagUrl,
    };
  }
}
