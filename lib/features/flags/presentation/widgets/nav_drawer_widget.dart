import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavDrawerWidget extends StatelessWidget {
  const NavDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: primary,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const SizedBox(
              height: 60,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
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
              onTapCall: () => SystemNavigator.pop(),
            ),
          ],
        ),
      ),
    );
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
        color: Colors.white,
      ),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
