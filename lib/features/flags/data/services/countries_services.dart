import 'package:flags_task/features/flags/data/db/flags_database.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/data/providers/countries_api_provider.dart';

// Implementations of the Business Logic as Services
class CountriesServices {
  Future<List<CountryModel>> fetchCountriesFromApi() async {
    var apiProvider = CountriesApiProvider();
    final result = await apiProvider.getAllCountries();
    return result;
  }

  insertIntoDB(List<CountryModel> countries) async {
    await FlagsDatabase.db.insertCountries(countries);
  }

  Future<bool> checkIfDataNotPersists() async {
    final count = await FlagsDatabase.db.readRowCount();
    if (count == 0) {
      // When no Data in DB
      return true;
    } else {
      // API data has populated DB
      return false;
    }
  }
}
