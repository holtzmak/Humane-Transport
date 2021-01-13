import 'package:app/common/style/style.dart';
import 'package:app/models/nav_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/navigation_provider.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, model, child) => BottomNavigationBar(
        items: allNavItems.map((NavigationItems navItem) {
          return BottomNavigationBarItem(
              icon: Icon(navItem.icon), label: navItem.label);
        }).toList(),
        currentIndex: model.getIndex,
        onTap: (int index) => model.setIndex = index,
        selectedItemColor: MainAppColor,
      ),
    );
  }
}
