import 'package:app/ui/widgets/utility/setting_icon.dart';
import 'package:flutter/material.dart';

// The padding property can be added to style.dart, but doing so would be overkill:
// https://stackoverflow.com/questions/44053363/flutter-padding-for-all-widgets

const SmallTextSize = 14.0;
const BodyTextSize = 16.0;
const MediumTextSize = 20.0;
const LargeTextSize = 23.0;

const NavyBlue = Color.fromRGBO(20, 57, 89, 1);
const White = Colors.white;
const Beige = Color.fromRGBO(191, 186, 159, 1);
const DarkerBeige = Color.fromRGBO(170, 160, 130, 1);
const SlateGrey = Color.fromRGBO(134, 151, 166, 1);
const AlmostBlack = Color(0xFF212121);
const OverlayColor = Color.fromRGBO(0, 0, 0, 0.5);

appBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
          color: NavyBlue,
          fontWeight: FontWeight.bold,
          fontSize: MediumTextSize),
    ),
    automaticallyImplyLeading: false,
    backgroundColor: White,
  );
}

appBarInner(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: TextStyle(
          color: NavyBlue,
          fontWeight: FontWeight.bold,
          fontSize: MediumTextSize),
    ),
    backgroundColor: White,
    actions: <Widget>[SettingIconWidget()],
  );
}

const TitleTextStyle = TextStyle(
  fontSize: LargeTextSize,
  color: AlmostBlack,
);

const BodyTextStyle = TextStyle(
  fontSize: SmallTextSize,
  color: NavyBlue,
);

const SubHeadingTextStyle = TextStyle(
  fontSize: BodyTextSize,
  color: NavyBlue,
);

const CaptionStyle = TextStyle(
  fontSize: SmallTextSize,
  color: AlmostBlack,
);

const DefaultRaisedButtonStyle = ButtonThemeData(
  buttonColor: NavyBlue,
);

const AppTimePickerTheme = TimePickerThemeData(
  hourMinuteColor: NavyBlue,
  hourMinuteTextColor: Colors.white,
  dialHandColor: NavyBlue,
);
