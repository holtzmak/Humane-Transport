import 'package:app/common/style/style.dart';
import 'package:app/common/widgets/list_tile.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        // TODOS: Add more rows(e.g. user img) and styling
        children: [
          DrawerHeader(
            child: Text('Hello'),
            decoration: BoxDecoration(
              gradient: GradientColors,
            ),
          ),
          TemplateListTile(
            icon: Icons.home_outlined,
            text: 'New Travel',
            textStyle: Theme.of(context).textTheme.bodyText1,
            selectedIndex: 0,
          ),
          SizedBox(
            height: 5.0,
          ),
          TemplateListTile(
            icon: Icons.add_circle_outline,
            text: 'Ongoing travel',
            textStyle: Theme.of(context).textTheme.bodyText1,
            selectedIndex: 1,
          ),
          SizedBox(
            height: 5.0,
          ),
          TemplateListTile(
            icon: Icons.history,
            text: 'Travel History',
            textStyle: Theme.of(context).textTheme.bodyText1,
            selectedIndex: 2,
          ),
        ],
      ),
    );
  }
}
