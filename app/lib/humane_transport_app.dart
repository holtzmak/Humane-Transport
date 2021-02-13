import 'package:app/ui/common/style/style.dart';
import 'package:app/ui/routes/main_navigator/app_route.dart';
import 'package:flutter/material.dart';
import 'core/services/dialog/dialog_service.dart';
import 'core/services/navigation/nav_service.dart';
import 'core/services/service_locator.dart';
import 'core/utilities/dialog_manager.dart';

class HumaneTransportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouteGenerator.onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigationKey,
      /*
      As per Filled stack suggestion, this must be wrapped with Navigator.
      https://medium.com/flutter-community/manager-your-flutter-dialogs-with-a-dialog-manager-1e862529523a
      */
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: MainAppColor),
        textTheme: TextTheme(
          headline5: TitleTextStyle,
          bodyText1: BodyTextStyle,
        ),
        iconTheme: IconThemeData(
          color: MainAppColor,
        ),
        buttonTheme: DefaultRaisedButtonStyle,
      ),
    );
  }
}
