import 'dart:async';
import 'package:flags_task/features/flags/data/services/countries_services.dart';
import 'package:flags_task/features/flags/presentation/pages/home_page.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flutter/material.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    });
    // Populates Database
    _populateDB();
  }

  @override
  Widget build(BuildContext context) {
    // Splash Screen Widget
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.cyan.shade300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        radius: 80.0,
                        child: Image.asset('assets/images/flag.png'),
                      ),
                    ),
                    Text(
                      "Countries!",
                      style: TextStyle(
                          color: highlight,
                          fontSize: 48,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 240,
                    ),
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Getting everything ready",
                      style: TextStyle(color: highlight, fontSize: 24),
                    )
                  ],
                ))
              ],
            ),
          )
        ],
      ),
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
