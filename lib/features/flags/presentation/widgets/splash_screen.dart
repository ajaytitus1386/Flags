import 'package:flags_task/features/flags/data/services/countries_services.dart';
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
    // Populates Database
    _populateDB();
    // Splash Screen Widget
    return SplashScreen(
      loaderColor: Colors.white,
      seconds: 5,
      navigateAfterSeconds: const HomePage(),
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

  _populateDB() async {
    final countriesServices = CountriesServices();
    if (await countriesServices.checkIfDataNotPersists()) {
      final countries = await countriesServices.fetchCountriesFromApi();
      await countriesServices.insertIntoDB(countries);
    }
  }
}
