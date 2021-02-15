import 'package:app/core/utilities/optional.dart';
import 'package:flutter/material.dart';

/// The Navigation Service which simplifies using main and inner navigators
class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return Optional(arguments).isPresent()
        ? _navigationKey.currentState.pushNamed(routeName, arguments: arguments)
        : _navigationKey.currentState.pushNamed(routeName);
  }

  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  Future<dynamic> navigateAndReplace(String routeName, {dynamic arguments}) {
    return Optional(arguments).isPresent()
        ? _navigationKey.currentState
            .pushReplacementNamed(routeName, arguments: arguments)
        : _navigationKey.currentState.pushReplacementNamed(routeName);
  }

  /// Calls [pop] repeatedly until the predicate returns true.
  /// Can be dangerous if the route name doesn't exist in routing tree
  void navigateBackUntil(String routeName) {
    _navigationKey.currentState.popUntil(ModalRoute.withName(routeName));
  }
}
