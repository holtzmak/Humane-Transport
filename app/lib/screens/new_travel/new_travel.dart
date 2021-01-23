import 'package:app/common/enums/app_state.dart';
import 'package:app/common/widgets/alert_dialog.dart';
import 'package:app/navigation/side_bar/sidebar.dart';
import 'package:app/providers/authentication/authentication.dart';
import 'package:app/screens/new_travel/new_travel_journey/test_screen_one.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTravel extends StatelessWidget {
  static const route = '/home/new_tavel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      drawer: SideBar(),
      body: Center(
        child: Consumer<AuthenticationProvider>(
          builder: (context, model, child) => Column(
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
              SizedBox(
                height: 50.0,
              ),
              Text('See if Future code will run, regardless of current screen'),
              RaisedButton(
                onPressed: () async => Future.delayed(Duration(seconds: 2))
                    .then((_) => launchAlertDialog(context,
                        title: "An alert in 2 seconds?",
                        warning: "I am the Future!")),
                child: Text('Launch Future (2 seconds delay)'),
              ),
              model.viewState == ViewState.Busy
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      onPressed: () {
                        model.signOut();
                      },
                      child: Text('Sign Out'),
                      color: Colors.red,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
