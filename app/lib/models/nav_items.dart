import 'package:flutter/material.dart';

class NavigationItems {
  final String label;
  final IconData icon;

  NavigationItems({this.label, this.icon});
}

List<NavigationItems> allNavItems = <NavigationItems>[
  NavigationItems(label: 'Home', icon: Icons.home_outlined),
  NavigationItems(label: 'New Travel', icon: Icons.add_circle_outline),
  NavigationItems(label: 'Travel History', icon: Icons.timeline_outlined),
];
