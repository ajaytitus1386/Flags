import 'package:flags_task/core/network/network_info.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CountriesApiProvider {
  /// Fetches JSON Response from API endpoint and inserts it into database
  ///
  /// Returns `List<CountryModel>` from parsed JSON
  Future<List<CountryModel>> getAllCountries() async {
    NetworkInfo networkInfo = NetworkInfoImpl(InternetConnectionChecker());
    if (await networkInfo.isConnected) {
      const url = "https://restcountries.com/v3.1/all";

      final response = await http
          .get(Uri.parse(url), headers: {"Content-Type": 'application/json'});

      if (response.statusCode == 200) {
        final result = countriesFromJson(response.body);

        return result;
      }
      throw {Exception('HTTP fetch Failed')};
    } else {
      throw Exception('Not connected to Internet');
    }
  }
}
