import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String cca3;
  final String capital;
  final List<String> borders;
  final List<String> languages;
  final String region;
  final String flagUrl;

  const Country({
    required this.name,
    required this.cca3,
    required this.capital,
    required this.borders,
    required this.languages,
    required this.region,
    required this.flagUrl,
  }) : super();

  @override
  List<Object?> get props =>
      [name, cca3, capital, borders, languages, region, flagUrl];
}
