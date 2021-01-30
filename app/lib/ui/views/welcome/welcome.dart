import 'package:app/core/view_models/welcome_view_model.dart';
import 'package:app/ui/views/base_view.dart';
import 'package:app/ui/views/signin/sign_in.dart';
import 'package:app/ui/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final String title;
  const Welcome({Key key, this.title}) : super(key: key);
  static const route = '/';
  @override
  Widget build(BuildContext context) {
    return BaseView<WelcomeViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        drawer: SideBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome User'),
              // TODO: Register button
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignInScreen.route);
                },
                child: Text('Continue'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
