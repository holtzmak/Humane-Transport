import 'package:app/common/style/style.dart';
import 'package:app/navigations/nav_bar/navigation.dart';
import 'package:app/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigations/side_bar/sidebar.dart';

class HumaneTransportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Start Application');
    return ChangeNotifierProvider<NavigationProvider>(
      create: (_) => NavigationProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MainAppColor,
        ),
        drawer: SideBar(),
        body: Consumer<NavigationProvider>(
          builder: (context, model, child) => IndexedStack(
            index: model.getIndex,
            children: model.getCurrentScreen,
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
