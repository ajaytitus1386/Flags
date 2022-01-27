import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/presentation/bloc/country_bloc.dart';
import 'package:flags_task/features/flags/presentation/global/event_dispatchers.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/widgets/country_list_builder.dart';
import 'package:flags_task/features/flags/presentation/widgets/heading_card.dart';
import 'package:flags_task/features/flags/presentation/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegionPage extends StatefulWidget {
  final String region;
  const RegionPage({Key? key, required this.region}) : super(key: key);

  @override
  _RegionPageState createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  List<CountryModel> countries = [];

  @override
  void initState() {
    super.initState();
    dispatchGetCountries(context, widget.region);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        child: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state is CountryInitial) {
              dispatchGetCountries(context, widget.region);
              return Center(
                child: CircularProgressIndicator(
                  color: primary,
                ),
              );
            } else if (state is CountryLoaded) {
              return CountryListBuilder(countries: state.countries);
            }
            return const HeadingCard(
                heading: 'Oops something went wrong! Please Try again later');
          },
        ),
        appBarTitle: widget.region);
  }
}
