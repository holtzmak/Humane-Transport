import 'package:app/ui/common/style/style.dart';
import 'package:app/ui/routes/main_navigator/app_route.dart';
import 'package:app/ui/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'core/services/dialogs/dialogs_service.dart';
import 'core/services/navigation/nav_service.dart';
import 'core/services/service_locator.dart';
import 'core/utilities/dialog_manager.dart';

class HumaneTransportApp extends StatefulWidget {
  @override
  _HumaneTransportAppState createState() => _HumaneTransportAppState();
}

class _HumaneTransportAppState extends State<HumaneTransportApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.route,
      onGenerateRoute: AppRouteGenerator.onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigationKey,
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
