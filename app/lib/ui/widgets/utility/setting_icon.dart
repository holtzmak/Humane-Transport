import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/views/setting_screen.dart';
import 'package:flutter/material.dart';

class SettingIconWidget extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: NavyBlue,
                size: 30,
              ),
              onPressed: () =>
                  _navigationService.navigateTo(SettingScreen.route))
        ],
      ),
    );
  }
}
