import 'package:app/navbar/navigation.dart';
import 'package:app/style/style.dart';
import 'package:flutter/material.dart';

class TemplateListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle textStyle;

  TemplateListTile(
      {@required this.icon, @required this.text, @required this.textStyle}) {
    assert(icon != null);
    assert(text != null);
    assert(textStyle != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BottomBorderStyle,
        ),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement a better way of routing
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationBarController()),
          );
        },
        child: Row(
          children: [
            Padding(
              /*
                The padding property can be added to style.dart,
                but doing so would be an overkill.
                Source: https://stackoverflow.com/questions/44053363/flutter-padding-for-all-widgets
              */
              padding: const EdgeInsets.all(5.0),
              child: Icon(icon),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
