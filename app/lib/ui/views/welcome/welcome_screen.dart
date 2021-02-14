import 'package:app/core/view_models/welcome_view_model.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/views/navigation_drawer.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String title;

  const WelcomeScreen({Key key, this.title}) : super(key: key);
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<WelcomeViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        drawer: NavigationDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome!'),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignInScreen.route);
                },
                child: Text('Sign In'),
              ),
              // TODO: Remove eventually, useful for testing now
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(HomeScreen.route);
                },
                child: Text('Skip sign in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
