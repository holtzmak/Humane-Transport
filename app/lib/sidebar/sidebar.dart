import 'package:app/sidebar/local_widgets/list_tile.dart';
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
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.green,
                  Colors.greenAccent,
                ],
              ),
            ),
          ),
          CustomTile(
            icon: Icons.star_border,
            text: 'In Progress',
          ),
          SizedBox(
            height: 5.0,
          ),
          CustomTile(
            icon: Icons.history,
            text: 'Travel History',
          ),
        ],
      ),
    );
  }
}
