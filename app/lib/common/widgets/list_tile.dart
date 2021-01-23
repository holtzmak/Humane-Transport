import 'package:app/common/style/style.dart';
import 'package:app/providers/navigation/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemplateListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle textStyle;
  final int selectedIndex;

  TemplateListTile(
      {@required this.icon,
      @required this.text,
      @required this.textStyle,
      @required this.selectedIndex}) {
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
          Navigator.of(context).pop();
          Provider.of<NavigationProvider>(context, listen: false).setIndex =
              selectedIndex;
        },
        child: Row(
          children: [
            Padding(
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
