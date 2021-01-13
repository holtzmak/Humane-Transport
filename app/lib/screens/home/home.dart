import 'package:app/navigations/nav_bar/navigation.dart';
import 'package:app/navigations/side_bar/sidebar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Home'),
      ),
      bottomNavigationBar: NavigationBarController(),
    );
  }
}
