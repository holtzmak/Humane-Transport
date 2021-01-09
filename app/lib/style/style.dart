import 'package:flutter/material.dart';

const SmallTextSize = 14.0;
const BodyTextSize = 16.0;
const MediumTextSize = 20.0;
const LargeTextSize = 23.0;

const SelectedItemColor = Colors.green;

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

const DefaultRaisedButtonStyle = ButtonThemeData(
  buttonColor: Colors.green,
);
