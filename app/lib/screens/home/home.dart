import 'package:app/navigation/nav_bar/navigation.dart';
import 'package:app/navigation/side_bar/sidebar.dart';
import 'package:app/providers/navigation_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Application starting....');
    return Scaffold(
      appBar: AppBar(),
      drawer: SideBar(),
      body: Consumer<NavigationProvider>(
        builder: (context, model, _) => IndexedStack(
          index: model.getIndex,
          children: model.getCurrentScreen,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
