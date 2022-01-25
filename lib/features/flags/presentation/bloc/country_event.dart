part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class CountryRefresh extends CountryEvent {}

class PopulateCountriesDBEvent extends CountryEvent {}

class GetCountriesByRegionEvent extends CountryEvent {
  final String region;

  const GetCountriesByRegionEvent(this.region);
}

class GetCountriesByBordersEvent extends CountryEvent {
  final List<String> borders;

  const GetCountriesByBordersEvent(this.borders);
}
