import 'package:app/models/nav_item_model.dart';
import 'package:flutter/material.dart';

class TemplateNavigator extends StatelessWidget {
  const TemplateNavigator({Key key, this.navigationItem}) : super(key: key);
  final NavigationItemModel navigationItem;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigationItem.navigatorState,
      initialRoute: navigationItem.initialRoute,
      onGenerateRoute: navigationItem.onGenerateRoute,
    );
  }
}
