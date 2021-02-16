import 'package:app/core/view_models/sign_in_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

// TODO: Update as per #152.
class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const route = '/signIn';

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<SignInViewModel>(
      builder: (context, model, child) => BusyOverlayScreen(
        show: model.state == ViewState.Busy,
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    onPressed: () => model.navigateToWelcomeScreen(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
