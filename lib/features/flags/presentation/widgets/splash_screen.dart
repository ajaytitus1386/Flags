import 'package:flags_task/features/flags/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: HomePage(),
      title: const Text(
        'Countries!',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 64),
      ),
      backgroundColor: Colors.cyan.shade300,
      image: Image.asset('assets/images/flag.jpg'),
      photoSize: 80,
      loadingText: const Text('Getting Everything Ready!',
          style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }
}
