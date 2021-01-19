import 'package:app/screens/new_travel/new_travel_journey/test_screen_one.dart';
import 'package:flutter/material.dart';

class NewTravel extends StatelessWidget {
  static const route = '/home/new_tavel';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Go to page with bottom nav'),
            RaisedButton(
              onPressed: () => Navigator.of(context, rootNavigator: false)
                  .pushNamed(TestScreenOne.route),
              child: Text('Go Next'),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text('Go to page without bottom nav'),
            RaisedButton(
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .pushNamed(TestScreenOne.route),
              child: Text('Go Next'),
            ),
          ],
        ),
      ),
    );
  }
}
