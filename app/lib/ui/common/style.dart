import 'package:flutter/material.dart';

/*
    The padding property can be added to style.dart, but doing so would be overkill:
    https://stackoverflow.com/questions/44053363/flutter-padding-for-all-widgets
  */
const SmallTextSize = 14.0;
const BodyTextSize = 16.0;
const MediumTextSize = 20.0;
const LargeTextSize = 23.0;

const buttonColor = Color.fromRGBO(20, 57, 89, 1);
const appBarColor = Colors.white;
const homeBackground = Color.fromRGBO(191, 186, 159, 1);
const bottomNavBarColor = Color.fromRGBO(134, 151, 166, 1);

const MainAppColor = Color(0xff66bb6a);

appBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
          color: buttonColor,
          fontWeight: FontWeight.bold,
          fontSize: MediumTextSize),
    ),
    automaticallyImplyLeading: false,
    backgroundColor: appBarColor,
  );
}

const BottomBorderStyle = BorderSide(
  // Add more properties if needed
  color: Color(0xFFBDBDBD),
);

const GradientColors = LinearGradient(
  // Add more properties if needed
  colors: [Colors.green, Colors.greenAccent],
);

const TitleTextStyle = TextStyle(
  fontSize: LargeTextSize,
  color: Color(0xFF212121),
);

const BodyTextStyle = TextStyle(
  fontSize: SmallTextSize,
  color: Color(0xFF212121),
  letterSpacing: 1.5,
);

const DefaultButtonTheme = ButtonThemeData(
  minWidth: 25,
  padding: EdgeInsets.all(20),
  buttonColor: buttonColor,
);

const DefaultRaisedButtonStyle = ButtonThemeData(
  buttonColor: buttonColor,
);

const OverlayColor = Color.fromRGBO(0, 0, 0, 0.5);

const CircleAvatarBackgroundColor = Color(0xffFDCF09);
