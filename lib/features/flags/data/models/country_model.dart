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
  final List<String> borders;
  final List<String> languages;
  final String region;
  final String flagUrl;

  CountryModel({
    required this.name,
    required this.cca3,
    required this.capital,
    required this.borders,
    required this.languages,
    required this.region,
    required this.flagUrl,
  }) : super();

  /// Specifically converts json from given API endpoint to ```CountryModel```
  factory CountryModel.fromApiJson(Map<String, dynamic> json) {
    List<dynamic>? listOfBorders = json["borders"];
    List<String> borders;
    if (listOfBorders != null) {
      borders = listOfBorders.map((border) => border.toString()).toList();
    } else {
      borders = [""];
    }

    Map<String, dynamic>? mapOfLanguages = json["languages"];
    List<String> languages;
    if (mapOfLanguages != null) {
      languages =
          mapOfLanguages.values.map((language) => language.toString()).toList();
    } else {
      languages = [""];
    }

    List<dynamic>? listOfCapitals = json["capital"];
    String capital = listOfCapitals != null ? listOfCapitals.first : '';

    return CountryModel(
      name: json["name"]["common"] ?? '',
      cca3: json["cca3"] ?? '',
      capital: capital,
      borders: borders,
      languages: languages,
      region: json["region"] ?? '',
      flagUrl: json["flags"]["png"] ?? '',
    );
  }

  /// Converts json as stored in Database back to ```CountryModel```
  factory CountryModel.fromJson(Map<String, dynamic> map) {
    String borderString = map["borders"];
    List<String> borders = _parseStringToList(borderString);

    String languageString = map["languages"];
    List<String> languages = _parseStringToList(languageString);

    return CountryModel(
      name: map["name"] as String,
      cca3: map["cca3"] as String,
      capital: map["capital"] as String,
      borders: borders,
      languages: languages,
      region: map["region"] as String,
      flagUrl: map["flag_url"] as String,
    );
  }

  /// Returns a json object from ```CountryModel```
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cca3': cca3,
      'capital': capital,
      'borders': borders,
      'languages': languages,
      'region': region,
      'flagUrl': flagUrl,
    };
  }
}

List<String> _parseStringToList(String str) {
  str = str.replaceAll("[", "");
  str = str.replaceAll("]", "");
  List<String> list = str.split(", ");
  return list;
}
