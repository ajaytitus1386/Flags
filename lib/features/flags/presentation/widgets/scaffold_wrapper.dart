import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/responsive_size.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flags_task/features/flags/presentation/widgets/elastic_sidebar.dart';
import 'package:flutter/material.dart';

// Acts as a common wrapper with scaffold, drawer and appbar for other pages
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
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: buildDrawerHamburger(),
        centerTitle: true,
        title: Text(
          widget.appBarTitle,
          style: buildHeadingCardTextStyle(),
        ),
        backgroundColor: primary,
      ),
      body: SizedBox(
        height: SizeConfig.screenHeight,
        child: Stack(
          children: [
            widget.child,
            ElasticSidebar(
              isMenuOpen: isMenuOpen,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHamburger() {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
      },
    );
  }
}
