import 'package:app/ui/common/style.dart';
import 'package:app/ui/routes/app_route_generator.dart';
import 'package:app/ui/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'core/services/dialog_service.dart';
import 'core/services/nav_service.dart';
import 'core/services/service_locator.dart';
import 'ui/widgets/utility/dialog_screen.dart';

class HumaneTransportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouteGenerator.onGenerateRoute,
      initialRoute: SplashScreen.route,
      navigatorKey: locator<NavigationService>().navigationKey,
      /*
      As per Filled stack suggestion, this must be wrapped with Navigator.
      https://medium.com/flutter-community/manager-your-flutter-dialogs-with-a-dialog-manager-1e862529523a

      With the use of DialogService, we must use one navigator. Generating
      another navigator will not work as we only have the one service, and so
      the one GlobalKey.
      */
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) =>
            MaterialPageRoute(builder: (context) => DialogScreen(child: child)),
      ),
      theme: ThemeData(
        textTheme: TextTheme(
          headline5: TitleTextStyle,
          bodyText1: BodyTextStyle,
          bodyText2: BodyTextStyle,
          caption: CaptionStyle,
          subtitle1: SubHeadingTextStyle,
        ),
        buttonTheme: DefaultRaisedButtonStyle,
        timePickerTheme: AppTimePickerTheme,
      ),
    );
  }
}
