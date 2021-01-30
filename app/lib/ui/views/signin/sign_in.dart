import 'package:app/core/enums/view_state.dart';
import 'package:app/core/view_models/signin_view_model.dart';
import 'package:app/ui/views/base_view.dart';
import 'package:app/ui/widgets/busy_overlay.dart';
import 'package:app/ui/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const route = '/signIn';
  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
      builder: (context, model, child) => BusyOverlay(
        show: model.state == ViewState.Busy,
        child: Scaffold(
          appBar: AppBar(),
          drawer: SideBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TEST',
                    key: Key('test'),
                  ),
                  TextFormField(
                    key: Key('emailKey'),
                    decoration: InputDecoration(hintText: "Email"),
                    controller: emailController,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      model.signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                    },
                    child: Text('Sign In'),
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  RaisedButton(
                    child: Text('Go back to welcome screen'),
                    color: Colors.red,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
                // TODO: Account creation
              ),
            ),
          ),
        ),
      ),
    );
  }
}
