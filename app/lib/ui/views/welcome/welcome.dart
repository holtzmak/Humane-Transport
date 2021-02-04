import 'package:app/core/view_models/welcome_view_model.dart';
import 'package:app/ui/views/base_view.dart';
import 'package:app/ui/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const route = '/welcome';
  @override
  Widget build(BuildContext context) {
    return BaseView<WelcomeViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        drawer: SideBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
            SizedBox(
              height: 40.0,
            ),
            // Based on prototype 2, we have sign in and sign up button here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () => model.navigateToSignInView(),
                  child: Text('Sign In'),
                ),
                SizedBox(
                  width: 40.0,
                ),
                RaisedButton(
                  onPressed: () => model.navigateToSignUpView(),
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
