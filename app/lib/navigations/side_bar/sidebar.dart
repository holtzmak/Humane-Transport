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
            icon: Icons.star_border,
            text: 'In Progress',
            textStyle: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 5.0,
          ),
          TemplateListTile(
            icon: Icons.history,
            text: 'Travel History',
            textStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
