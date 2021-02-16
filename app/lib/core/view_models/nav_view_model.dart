import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/routes/inner_navigator/active_route_generator.dart';
import 'package:app/ui/routes/inner_navigator/history_route_generator.dart';
import 'package:app/ui/routes/inner_navigator/new_route_generator.dart';
import 'package:app/ui/views/active/active_screen.dart';
import 'package:app/ui/views/history/history_screen.dart';
import 'package:app/ui/views/new/new_screen.dart';
import 'package:app/ui/widgets/models/nav_item_model.dart';
import 'package:flutter/material.dart';

class NavigationViewModel extends BaseViewModel {
  int _index = 0;

  List<NavigationItemModel> _navigationItems = [
    NavigationItemModel(
      label: 'New',
      icon: Icons.add_circle_outline,
      initialRoute: NewScreen.route,
      onGenerateRoute: NewRouteGenerator.onGenerateRoute,
      navigatorState: GlobalKey<NavigatorState>(),
    ),
    NavigationItemModel(
      label: 'Active',
      icon: Icons.emoji_transportation_outlined,
      initialRoute: ActiveScreen.route,
      onGenerateRoute: ActiveRouteGenerator.onGenerateRoute,
      navigatorState: GlobalKey<NavigatorState>(),
    ),
    NavigationItemModel(
      label: 'History',
      icon: Icons.timeline_outlined,
      initialRoute: HistoryScreen.route,
      onGenerateRoute: HistoryRouteGenerator.onGenerateRoute,
      navigatorState: GlobalKey<NavigatorState>(),
    )
  ];

  List<NavigationItemModel> get getNavigationItems =>
      List.unmodifiable(_navigationItems);

  NavigationItemModel get currentScreen => _navigationItems[_index];

  get getIndex => _index;

  set setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
