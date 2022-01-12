import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flags_task/features/flags/presentation/widgets/nav_drawer_widget.dart';
import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatefulWidget {
  final Widget child;
  final String appBarTitle;
  const ScaffoldWrapper(
      {Key? key, required this.child, required this.appBarTitle})
      : super(key: key);

  @override
  State<ScaffoldWrapper> createState() => _ScaffoldWrapperState();
}

class _ScaffoldWrapperState extends State<ScaffoldWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.appBarTitle,
          style: buildHeadingCardTextStyle(),
        ),
        backgroundColor: primary,
      ),
      body: widget.child,
    );
  }
}
