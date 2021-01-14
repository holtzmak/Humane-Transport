import 'package:app/screens/history/history.dart';
import 'package:app/screens/new_travel/new_travel.dart';
import 'package:app/screens/ongoing/ongoing.dart';
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _index = 0;
  List<Widget> _screens = <Widget>[
    NewTravel(),
    OngoingTravel(),
    TravelHistory(),
  ];
  get getIndex => _index;
  set setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  get getCurrentScreen => _screens;
}
