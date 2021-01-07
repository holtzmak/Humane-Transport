import 'package:app/navbar/navigation.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String text;

  CustomTile({@required this.icon, @required this.text}) {
    assert(icon != null);
    assert(text != null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[400]),
          ),
        ),
        child: InkWell(
          onTap: () {
            // TODO: Implement a better way of routing
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationBarController()),
            );
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(icon),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
