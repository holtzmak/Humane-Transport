import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/welcome_view_model.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final String title;

  WelcomeScreen({Key key, this.title}) : super(key: key);
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<WelcomeViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome!'),
              RaisedButton(
                onPressed: () {
                  _navigationService.navigateTo(SignInScreen.route);
                },
                child: Text('Sign In'),
              ),
              // TODO: Remove eventually, useful for testing now
              RaisedButton(
                onPressed: () {
                  _navigationService.navigateTo(HomeScreen.route);
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
