import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/views/new_travel/test_screens/test_screen_one.dart';
import 'package:flutter/material.dart';

class TestScreenTwo extends StatelessWidget {
  const TestScreenTwo({Key key}) : super(key: key);
  static const route = '${TestScreenOne.route}/test_screen_two';

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
            Text('Go back 1 page'),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Go Back'),
            ),
            SizedBox(
              height: 80.0,
            ),
            // Will pop all screens in the stack
            Text('Go to root and pop everything in the stack'),
            RaisedButton(
              color: Colors.red,
              child: Text('Submit'),
              onPressed: () => Navigator.of(context)
                  .popUntil(ModalRoute.withName(HomeScreen.route)),
            ),
          ],
        ),
      ),
    );
  }
}
