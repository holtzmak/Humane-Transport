import 'package:app/common/style/style.dart';
import 'package:app/providers/authentication/authentication.dart';
import 'package:app/providers/navigation/navigation_provider.dart';
import 'package:app/routes/main_navigator/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HumaneTransportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
            create: (context) => NavigationProvider()),
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (context) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationProvider>().authStateChanges),
      ],
      child: Builder(
          builder: (context) => MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRouteGenerator.onGenerateRoute,
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
              )),
    );
  }
}
