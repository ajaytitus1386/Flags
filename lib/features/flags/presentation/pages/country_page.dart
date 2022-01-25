import 'package:flags_task/features/flags/domain/entities/country.dart';
import 'package:flags_task/features/flags/presentation/bloc/country_bloc.dart';
import 'package:flags_task/features/flags/presentation/global/event_dispatchers.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/widgets/country_list_builder.dart';
import 'package:flags_task/features/flags/presentation/widgets/heading_card.dart';
import 'package:flags_task/features/flags/presentation/widgets/languages_list_builder.dart';
import 'package:flags_task/features/flags/presentation/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryPage extends StatefulWidget {
  final Country country;
  const CountryPage({Key? key, required this.country}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    dispatchGetCountriesByBorders(context, widget.country.borders);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        child: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state is CountryInitial) {
              return Center(
                child: CircularProgressIndicator(
                  color: primary,
                ),
              );
            } else if (state is CountryLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const HeadingCard(heading: 'Languages Spoken'),
                  LanguageListBuilder(languages: widget.country.languages),
                  _buildBorderingHeading(state.countries),
                  _buildBorderingCountriesList(state.countries),
                ],
              );
            }
            return const HeadingCard(
                heading: 'Oops something went wrong! Try again later');
          },
        ),
        appBarTitle: widget.country.name);
  }
}

Widget _buildBorderingHeading(List<Country> countries) {
  if (countries.isNotEmpty) {
    return const HeadingCard(heading: 'Bordering Countries');
  } else {
    return const SizedBox.shrink();
  }
}

Widget _buildBorderingCountriesList(List<Country> countries) {
  if (countries.isNotEmpty) {
    return Expanded(child: CountryListBuilder(countries: countries));
  } else {
    return const SizedBox.shrink();
  }
}
