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
  Offset offset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: background,
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
        child: GestureDetector(
          onPanUpdate: (details) {
            // Only if gesture is within sidebar bounds
            if (details.localPosition.dx <= SizeConfig.sidebarWidth) {
              setState(() {
                //Gives location of users finger on touch
                offset = details.localPosition;
              });
            }
            if (details.localPosition.dx > SizeConfig.screenWidth / 2 &&
                details.delta.distanceSquared > 2) {
              setState(() {
                isMenuOpen = true;
              });
            }
            if (details.localPosition.dx < SizeConfig.screenWidth / 2 &&
                details.delta.distanceSquared > 2) {
              setState(() {
                isMenuOpen = false;
              });
            }
          },
          onPanEnd: (details) {
            setState(() {
              // Reset to zero when user lifts finger
              offset = const Offset(0, 0);
            });
          },
          child: Stack(
            children: [
              widget.child,
              Visibility(
                  visible: isMenuOpen,
                  child: Opacity(
                    opacity: 0.25,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: gray50,
                    ),
                  )),
              ElasticSidebar(
                isMenuOpen: isMenuOpen,
              ),
            ],
          ),
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
