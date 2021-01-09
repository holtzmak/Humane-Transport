import 'package:app/screens/home/home.dart';
import 'package:app/style/style.dart';
import 'package:flutter/material.dart';

class HumaneTransportApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      // This is one way to consume styling properties inside style.dart
      theme: ThemeData(
        textTheme: TextTheme(
          headline5: TitleTextStyle,
          bodyText1: BodyTextStyle,
        ),
        iconTheme: IconThemeData(
          color: SelectedItemColor,
        ),
        buttonTheme: DefaultRaisedButtonStyle,
      ),
    );
  }
}
