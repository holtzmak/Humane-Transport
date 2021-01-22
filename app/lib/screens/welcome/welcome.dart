import 'package:app/navigation/side_bar/sidebar.dart';
import 'package:app/screens/authenticate/auth_wrapper.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key key}) : super(key: key);
  static const route = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: SideBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
            // TODO: Register button
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AuthenticateWrapper.route);
              },
              child: Text('Sign in'),
            )
          ],
        ),
      ),
    );
  }
}
