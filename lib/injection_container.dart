import 'package:flags_task/core/network/network_info.dart';
import 'package:flags_task/features/flags/data/db/flags_database.dart';
import 'package:flags_task/features/flags/data/repos/country_repo_impl.dart';
import 'package:flags_task/features/flags/domain/repos/country_repo.dart';
import 'package:flags_task/features/flags/domain/usecases/get_countries_by_borders.dart';
import 'package:flags_task/features/flags/domain/usecases/get_countries_by_region.dart';
import 'package:flags_task/features/flags/domain/usecases/populate_countries_db.dart';
import 'package:flags_task/features/flags/presentation/bloc/country_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  sl.registerFactory(() => CountryBloc(
        populateCountriesDB: sl(),
        getCountriesByRegion: sl(),
        getCountriesByBorders: sl(),
      ));

  //Use cases
  sl.registerLazySingleton(() => PopulateCountriesDB(sl()));
  sl.registerLazySingleton(() => GetCountriesByRegion(sl()));
  sl.registerLazySingleton(() => GetCountriesByBorders(sl()));

  sl.registerLazySingleton<CountryRepo>(() => CountryRepoImpl(
        flagsDatabase: sl(),
      ));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External Dependencies
  sl.registerLazySingleton(() => FlagsDatabase.db);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
