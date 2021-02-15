import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';

class TestScreenThree extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  static const route = "${HomeScreen.route}/test_screen_three";

  TestScreenThree({Key key}) : super(key: key);

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
          onPressed: () => widget._navigationService.pop(),
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
