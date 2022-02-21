import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flags_task/features/flags/presentation/styling/responsive_size.dart';
import 'package:flags_task/features/flags/presentation/styling/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ElasticSidebar extends StatefulWidget {
  bool isMenuOpen;
  ElasticSidebar({Key? key, required this.isMenuOpen}) : super(key: key);

  @override
  State<ElasticSidebar> createState() => _ElasticSidebarState();
}

class _ElasticSidebarState extends State<ElasticSidebar> {
  Offset offset = const Offset(0, 0);
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1500),
      // + 20 is the visible hang that will be used to pull the sidebar
      left: widget.isMenuOpen ? 0 : -SizeConfig.sidebarWidth,
      top: 0,
      curve: Curves.elasticOut,
      child: SizedBox(
        width: SizeConfig.sidebarWidth,
        child: GestureDetector(
          onPanUpdate: (details) {
            // Only if gesture is within sidebar bounds
            if (details.localPosition.dx <= SizeConfig.sidebarWidth) {
              setState(() {
                //Gives location of users finger on touch
                offset = details.localPosition;
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
              CustomPaint(
                size: Size(SizeConfig.sidebarWidth, SizeConfig.screenHeight),
                painter: DrawerPainter(offset: offset),
              ),
              SizedBox(
                key: globalKey,
                height: SizeConfig.screenHeight,
                width: SizeConfig.sidebarWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Countries!',
                      style: buildHeadingCardTextStyle(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 8,
                      color: highlight,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    buildMenuTile(
                        text: 'Home',
                        icon: Icons.home,
                        onTapCall: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        }),
                    buildMenuTile(
                        text: 'Exit',
                        icon: Icons.exit_to_app,
                        onTapCall: () => SystemNavigator.pop())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerPainter extends CustomPainter {
  final Offset offset;

  DrawerPainter({required this.offset});

  /// Ensures that the quadratic bezier doesnt flex inwards
  double getConrolPointX(double width) {
    if (offset.dx == 0) {
      return width;
    } else if (offset.dx > width) {
      return offset.dx;
    } else {
      return width + 75;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primary; //..color = Colors.white..style = PaintStyle.fill
    Path path = Path();
    // The drawer covers the negative region outside the screens vision before being pulled in
    path.moveTo(-size.width, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        getConrolPointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(-size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Returns a Tile in the Side Drawer
Widget buildMenuTile({
  required String text,
  required IconData icon,
  VoidCallback? onTapCall,
}) {
  return ListTile(
    onTap: onTapCall,
    leading: Icon(
      icon,
      color: highlight,
    ),
    title: Text(
      text,
      style: TextStyle(color: highlight, fontSize: 24),
    ),
  );
}
