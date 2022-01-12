import 'package:flags_task/features/flags/data/db/flags_database.dart';
import 'package:flags_task/features/flags/data/providers/countries_api_provider.dart';
import 'package:flags_task/features/flags/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  Widget build(BuildContext context) {
    fetchFromApi();
    return SplashScreen(
      loaderColor: Colors.white,
      seconds: 5,
      navigateAfterSeconds: HomePage(),
      title: const Text(
        'Countries!',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 64),
      ),
      backgroundColor: Colors.cyan.shade300,
      image: Image.asset('assets/images/flag.png'),
      photoSize: 80,
      loadingText: const Text('Getting Everything Ready!',
          style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }

  fetchFromApi() async {
    if (await _checkIfDataNotPersists()) {
      var apiProvider = CountriesApiProvider();
      final result = await apiProvider.getAllCountries();
    }
  }

  Future<bool> _checkIfDataNotPersists() async {
    final count = await FlagsDatabase.db.readRowCount();
    if (count == 0) {
      // When no Data in DB
      return true;
    } else {
      // API data has populated DB
      return false;
    }
  }
}
