import 'package:flags_task/features/flags/data/db/flags_database.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:http/http.dart' as http;

class CountriesApiProvider {
  /// Fetches JSON Response from API endpoint and inserts it into database
  ///
  /// Returns `List<CountryModel>` from parsed JSON
  Future<List<CountryModel>> getAllCountries() async {
    const url = "https://restcountries.com/v3.1/all";

    final response = await http
        .get(Uri.parse(url), headers: {"Content-Type": 'application/json'});

    if (response.statusCode == 200) {
      final result = countriesFromJson(response.body);

      for (var country in result) {
        await FlagsDatabase.db.insertCountry(country);
      }

      return result;
    }
    throw {Exception('HTTP fetch Failed')};
  }
}
