import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flags_task/core/error/failures.dart';
import 'package:flags_task/core/usecases/usecase.dart';
import 'package:flags_task/features/flags/domain/entities/country.dart';
import 'package:flags_task/features/flags/domain/usecases/get_countries_by_borders.dart';
import 'package:flags_task/features/flags/domain/usecases/get_countries_by_region.dart';
import 'package:flags_task/features/flags/domain/usecases/populate_countries_db.dart';

part 'country_event.dart';
part 'country_state.dart';

const String serverFailureMessage = 'Server Failure';
const String databaseFailureMessage = 'Database Failure';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final PopulateCountriesDB populateCountriesDB;
  final GetCountriesByRegion getCountriesByRegion;
  final GetCountriesByBorders getCountriesByBorders;

  CountryBloc({
    required this.populateCountriesDB,
    required this.getCountriesByRegion,
    required this.getCountriesByBorders,
  }) : super(CountryInitial()) {
    on<CountryEvent>((event, emit) {
      emit(CountryInitial());
    });
    on<CountryRefresh>((event, emit) {
      emit(CountryInitial());
    });
    on<PopulateCountriesDBEvent>((event, emit) async {
      emit(CountryLoading());
      final failureOrVoid = await populateCountriesDB(NoParams());
      emit(eitherFailureOrVoid(failureOrVoid));
    });
    on<GetCountriesByRegionEvent>((event, emit) async {
      emit(CountryLoading());
      final failureOrCountries =
          await getCountriesByRegion(RegionParams(event.region));
      emit(eitherFailureOrCountries(failureOrCountries));
    });
    on<GetCountriesByBordersEvent>((event, emit) async {
      emit(CountryLoading());
      final failureOrCountries =
          await getCountriesByBorders(BordersParams(event.borders));
      emit(eitherFailureOrCountries(failureOrCountries));
    });
  }

  CountryState eitherFailureOrVoid(Either<Failure, void> failureOrVoid) {
    return failureOrVoid.fold(
        (failure) => CountryError(message: _mapFailureToMessage(failure)),
        (right) => CountryInitial());
  }

  CountryState eitherFailureOrCountries(
      Either<Failure, List<Country>> failureOrCountries) {
    return failureOrCountries.fold(
        (failure) => CountryError(message: _mapFailureToMessage(failure)),
        (countries) => CountryLoaded(countries: countries));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case DatabaseFailure:
        return databaseFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
