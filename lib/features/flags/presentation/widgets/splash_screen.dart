import 'dart:async';
import 'package:flags_task/features/flags/presentation/global/event_dispatchers.dart';
import 'package:flags_task/features/flags/presentation/pages/home_page.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    dispatchPopulate(context);
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    });
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
}
