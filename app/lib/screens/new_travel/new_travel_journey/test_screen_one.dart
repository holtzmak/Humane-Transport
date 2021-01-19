import 'package:app/screens/new_travel/new_travel.dart';
import 'package:app/screens/new_travel/new_travel_journey/test_screen_two.dart';
import 'package:flutter/material.dart';

class TestScreenOne extends StatefulWidget {
  const TestScreenOne({Key key}) : super(key: key);
  static const route = '${NewTravel.route}/test_screen_one';

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

            // TODO: Warn user data will be lost if not save
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
