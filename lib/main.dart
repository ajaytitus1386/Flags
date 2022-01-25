import 'package:flags_task/features/flags/presentation/bloc/country_bloc.dart';
import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/widgets/splash_screen.dart';
import 'package:flags_task/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountryBloc>(
      create: (_) => sl<CountryBloc>(),
      child: MaterialApp(
          title: 'Flags Task',
          theme:
              ThemeData(primaryColor: primary, secondaryHeaderColor: secondary),
          home: const SplashScreen()),
    );
  }
}
