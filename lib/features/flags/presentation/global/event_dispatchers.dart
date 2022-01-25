import 'package:flags_task/features/flags/presentation/bloc/country_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void dispatchPopulate(BuildContext context) {
  BlocProvider.of<CountryBloc>(context).add(PopulateCountriesDBEvent());
}

void dispatchGetCountriesByBorders(BuildContext context, List<String> borders) {
  print("By borders");
  BlocProvider.of<CountryBloc>(context)
      .add(GetCountriesByBordersEvent(borders));
}

void dispatchGetCountries(BuildContext context, String region) {
  print("By region");
  BlocProvider.of<CountryBloc>(context).add(GetCountriesByRegionEvent(region));
}

void dispatchRefresh(BuildContext context) {
  print("Does refresh");
  BlocProvider.of<CountryBloc>(context).add(CountryRefresh());
}
