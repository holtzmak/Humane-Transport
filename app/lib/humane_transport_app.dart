import 'package:app/common/style/style.dart';
import 'package:app/providers/navigation_provider.dart';
import 'package:app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HumaneTransportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<NavigationProvider>(
        create: (context) => NavigationProvider(),
        child: HomeScreen(),
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
