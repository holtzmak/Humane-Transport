import 'package:app/ui/views/new_travel/test_screens/test_screen_two.dart';
import 'package:flutter/material.dart';

import '../new_screen.dart';

class TestScreenOne extends StatefulWidget {
  const TestScreenOne({Key key}) : super(key: key);
  static const route = '${NewScreen.route}/test_screen_one';

  @override
  _TestScreenOneState createState() => _TestScreenOneState();
}

class _TestScreenOneState extends State<TestScreenOne> {
  int _counter = 0;

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
            Text('Welcome to Test screen 1'),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(TestScreenTwo.route),
              child: Text('Go Next'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Go Back'),
            ),
            SizedBox(
              height: 80.0,
            ),
            Text('Counter is $_counter'),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
