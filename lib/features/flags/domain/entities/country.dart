class Country {
  final String name;
  final String cca3;
  final String capital;
  final List<String> borders;
  final Map<String, String> languages;
  final String region;
  final String flagUrl;

  Country({
    required this.name,
    required this.cca3,
    required this.capital,
    required this.borders,
    required this.languages,
    required this.region,
    required this.flagUrl,
  }) : super();
}
