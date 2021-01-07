import 'package:app/screens/history/history.dart';
import 'package:app/screens/in_progress/in_progress.dart';
import 'package:flutter/material.dart';

class NavigationBarController extends StatefulWidget {
  @override
  _NavigationBarControllerState createState() =>
      _NavigationBarControllerState();
}

class _NavigationBarControllerState extends State<NavigationBarController> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    InProgress(),
    TravelHistory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'In Progress',
            icon: Icon(Icons.star_border_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Travel History',
            icon: Icon(Icons.history_edu_outlined),
          ),
        ],
        currentIndex: _selectedIndex,
        //Update the state when user selected an item
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.green,
      ),
    );
  }
}
