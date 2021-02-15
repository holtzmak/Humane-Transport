import 'package:flutter/material.dart';

class TestScreenThree extends StatefulWidget {
  const TestScreenThree({Key key}) : super(key: key);

  @override
  _TestScreenThreeState createState() => _TestScreenThreeState();
}

class _TestScreenThreeState extends State<TestScreenThree> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to Test screen 3'),
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
