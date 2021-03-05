import 'package:app/ui/common/style/style.dart';
import 'package:flutter/material.dart';

import '../widgets/utility/drawer_list_tile.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              gradient: GradientColors,
            ),
          ),
          DrawerListTile(
            icon: Icons.home_outlined,
            text: 'Home',
            textStyle: Theme.of(context).textTheme.bodyText1,
            selectedIndex: 0,
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          DrawerListTile(
            icon: Icons.add_circle_outline,
            text: 'Active',
            textStyle: Theme.of(context).textTheme.bodyText1,
            selectedIndex: 1,
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          DrawerListTile(
            icon: Icons.history,
            text: 'History',
            textStyle: Theme.of(context).textTheme.bodyText1,
            selectedIndex: 2,
          ),
        ],
      ),
    );
  }
}
