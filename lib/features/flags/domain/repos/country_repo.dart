import 'package:dartz/dartz.dart';
import 'package:flags_task/core/error/failures.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/domain/entities/country.dart';

abstract class CountryRepo {
  Future<Either<Failure, List<CountryModel>>> fetchAllCountriesFromApi();
  Future<Either<Failure, void>> insertCountriesIntoDB(
      List<CountryModel> countries);
  Future<Either<Failure, bool>> checkIfDataNotPersists();

  /// Returns a `List<Country>` based on a region
  Future<Either<Failure, List<Country>>> getCountriesByRegion(String region);

  /// Returns a `List<Country>` based on a list of cca3 ids
  Future<Either<Failure, List<Country>>> getCountriesByBorders(
      List<String> borders);

  /// Fetches the API response data, formats it and inserts it into the DB
  /// only if there is no data already persisting in the DB
  Future<Either<Failure, void>> populateCountriesDB();
}
