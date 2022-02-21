import 'package:flags_task/features/flags/domain/entities/country.dart';
import 'package:flags_task/features/flags/presentation/bloc/country_bloc.dart';
import 'package:flags_task/features/flags/presentation/global/event_dispatchers.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flags_task/features/flags/presentation/widgets/country_list_builder.dart';
import 'package:flags_task/features/flags/presentation/widgets/error_card_widget.dart';
import 'package:flags_task/features/flags/presentation/widgets/languages_list_builder.dart';
import 'package:flags_task/features/flags/presentation/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class CountryPage extends StatefulWidget {
  final Country country;
  const CountryPage({Key? key, required this.country}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<Country> countries = [];
  final double _horizontalPadding = 16;

  @override
  void initState() {
    super.initState();
    dispatchGetCountriesByBorders(context, widget.country.borders);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        dispatchRefresh(context);
        return Future.value(true);
      },
      child: BlocProvider(
        create: (context) => sl<CountryBloc>(),
        child: ScaffoldWrapper(
            child: BlocBuilder<CountryBloc, CountryState>(
              builder: (context, state) {
                if (state is CountryInitial) {
                  dispatchGetCountriesByBorders(
                      context, widget.country.borders);
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
                        height: 30,
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(widget.country.flagUrl),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _horizontalPadding),
                        child: _buildHeading(heading: "Languages Spoken"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _horizontalPadding),
                        child: LanguageListBuilder(
                            languages: widget.country.languages),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _horizontalPadding),
                        child: _buildBorderingHeading(state.countries),
                      ),
                      //No Horizontal padding of this country list
                      _buildBorderingCountriesList(state.countries),
                    ],
                  );
                } else if (state is CountryError) {
                  return ErrorCardWidget(message: state.message);
                }
                return const SizedBox.shrink();
              },
            ),
            appBarTitle: widget.country.name),
      ),
    );
  }
}

Widget _buildBorderingHeading(List<Country> countries) {
  if (countries.isNotEmpty) {
    return _buildHeading(heading: 'Bordering Countries');
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

Widget _buildHeading({required String heading}) {
  return Text(
    heading,
    style: buildHeadingTextStyle(),
  );
}
