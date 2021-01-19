import 'package:app/models/nav_items.dart';
import 'package:app/routes/inner_navigator/history_route.dart';
import 'package:app/routes/inner_navigator/new_travel_route.dart';
import 'package:app/routes/inner_navigator/ongoing_route.dart';
import 'package:app/screens/history/history.dart';
import 'package:app/screens/new_travel/new_travel.dart';
import 'package:app/screens/ongoing/ongoing.dart';
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _index = 0;

  List<NavigationItem> _navigationItems = [
    NavigationItem(
      label: 'New Travel',
      icon: Icons.add_circle_outline,
      initialRoute: NewTravel.route,
      onGenerateRoute: NewTravelRouteGenerator.onGenerateRoute,
      navigatorState: GlobalKey<NavigatorState>(),
    ),
    NavigationItem(
      label: 'Ongoing',
      icon: Icons.emoji_transportation_outlined,
      initialRoute: OngoingTravel.route,
      onGenerateRoute: OngoingRouteGenerator.onGenerateRoute,
      navigatorState: GlobalKey<NavigatorState>(),
    ),
    NavigationItem(
      label: 'Travel History',
      icon: Icons.timeline_outlined,
      initialRoute: TravelHistory.route,
      onGenerateRoute: HistoryRouteGenerator.onGenerateRoute,
      navigatorState: GlobalKey<NavigatorState>(),
    )
  ];

  // Getters
  List<NavigationItem> get getNavigationItems => _navigationItems;
  get getIndex => _index;
  NavigationItem get currentScreen => _navigationItems[_index];

  // Setters
  set setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
