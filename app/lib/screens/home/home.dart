import 'package:app/common/style/style.dart';
import 'package:app/navigation/nav_bar/template_navigator.dart';
import 'package:app/providers/navigation_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRootScreen extends StatelessWidget {
  static const route = '/';
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(builder: (context, navProvider, child) {
      final bottomNavBarItems = navProvider.getNavigationItems
          .map((getNavigationItem) => BottomNavigationBarItem(
              icon: Icon(getNavigationItem.icon),
              label: getNavigationItem.label))
          .toList();

      final screens = navProvider.getNavigationItems
          .map((getNavigationItem) => TemplateNavigator(
                navigationItem: getNavigationItem,
              ))
          .toList();
      return Scaffold(
        body: IndexedStack(
          index: navProvider.getIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavBarItems,
          selectedItemColor: MainAppColor,
          currentIndex: navProvider.getIndex,
          onTap: (int index) => navProvider.setIndex = index,
        ),
      );
    });
  }
}
