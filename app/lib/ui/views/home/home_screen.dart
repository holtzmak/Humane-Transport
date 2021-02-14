import 'package:app/core/view_models/nav_view_model.dart';
import 'package:app/ui/common/style/style.dart';
import 'package:app/ui/views/navigation_drawer.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:app/ui/widgets/utility/template_navigator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<NavigationViewModel>(
        builder: (context, navProvider, child) {
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
        drawer: NavigationDrawer(),
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
