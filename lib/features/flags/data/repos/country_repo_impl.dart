import 'package:dartz/dartz.dart';
import 'package:flags_task/core/error/exceptions.dart';
import 'package:flags_task/core/error/failures.dart';
import 'package:flags_task/core/network/network_info.dart';
import 'package:flags_task/features/flags/data/db/flags_database.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/domain/entities/country.dart';
import 'package:flags_task/features/flags/domain/repos/country_repo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

class CountryRepoImpl implements CountryRepo {
  final FlagsDatabase flagsDatabase;

  CountryRepoImpl({required this.flagsDatabase});

  @override
  Future<Either<Failure, List<CountryModel>>> fetchAllCountriesFromApi() async {
    NetworkInfo networkInfo = NetworkInfoImpl(InternetConnectionChecker());
    if (await networkInfo.isConnected) {
      const url = "https://restcountries.com/v3.1/all";

      final response = await http
          .get(Uri.parse(url), headers: {"Content-Type": 'application/json'});

      if (response.statusCode == 200) {
        final result = countriesFromJson(response.body);
        return Right(result);
      }

      return Left(ServerFailure(message: 'HTTP Fetch failed'));
    } else {
      return Left(ServerFailure(message: 'Internet Connection Not Detected'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfDataNotPersists() async {
    final int? count;
    try {
      count = await FlagsDatabase.db.readRowCount();
    } on CountriesDatabaseException {
      return Left(DatabaseFailure(message: "Failed to read row count"));
    }
    if (count == 0) {
      // When no Data in DB
      return const Right(true);
    } else {
      // API data has populated DB
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, void>> insertCountriesIntoDB(
      List<CountryModel> countries) async {
    try {
      await FlagsDatabase.db.insertCountries(countries);
    } on CountriesDatabaseException {
      return Left(DatabaseFailure(message: 'Failed to insert countries to DB'));
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<Country>>> getCountriesByBorders(
      List<String> borders) async {
    List<Country> bordersList = [];
    if (borders.first == "") {
      return Right(bordersList);
    }
    for (var border in borders) {
      try {
        final result = await FlagsDatabase.db.readCountry(border);
        bordersList.add(result);
      } on CountriesDatabaseException {
        return Left(DatabaseFailure(message: "Failed to read country $border"));
      }
    }
    return Right(bordersList);
  }

  @override
  Future<Either<Failure, List<Country>>> getCountriesByRegion(
      String region) async {
    try {
      final result = await FlagsDatabase.db.readCountriesByRegion(region);
      return Right(result);
    } on CountriesDatabaseException {
      return Left(DatabaseFailure(
          message: 'Failed to read countries by Region $region'));
    }
  }

  @override
  Future<Either<Failure, void>> populateCountriesDB() async {
    try {
      // Check if the database has countries in it
      final eitherFailureOrDataNotPersists = await checkIfDataNotPersists();
      final isDataNotPersists = eitherFailureOrDataNotPersists.fold((failure) {
        throw failure;
      }, (right) {
        return right;
      });
      // If no countries in db
      if (isDataNotPersists) {
        // Fetch Countries
        final eitherFailureOrFetchedCountries =
            await fetchAllCountriesFromApi();
        final fetchedCountries =
            eitherFailureOrFetchedCountries.fold((failure) {
          throw failure;
        }, (right) {
          return right;
        });

        // Insert the fetched countries into the db
        final eitherFailureOrInsertCountries =
            await insertCountriesIntoDB(fetchedCountries);
        eitherFailureOrInsertCountries.fold((l) {
          return Left(DatabaseFailure(message: 'Failed to insert countries'));
        }, (right) {
          return Right(right);
        });
      }
      // If Data persists then no insert needed
      return const Right(null);
      // Exceptions during checks and fetch
    } on CountriesDatabaseException {
      return Left(
          DatabaseFailure(message: 'Database failed to insert countries'));
    } on ServerException {
      return Left(ServerFailure(message: 'Server failed to fetch countries'));
    }
  }
}
