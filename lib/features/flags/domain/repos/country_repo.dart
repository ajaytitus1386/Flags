import 'package:dartz/dartz.dart';
import 'package:flags_task/core/error/failures.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/domain/entities/country.dart';

abstract class CountryRepo {
  Future<Either<Failure, List<CountryModel>>> fetchAllCountriesFromApi();
  Future<Either<Failure, void>> insertCountriesIntoDB(
      List<CountryModel> countries);
  Future<Either<Failure, bool>> checkIfDataNotPersists();
  Future<Either<Failure, List<Country>>> getCountriesByRegion(String region);
  Future<Either<Failure, List<Country>>> getCountriesByBorders(
      List<String> borders);
  Future<Either<Failure, void>> populateCountriesDB();
}
