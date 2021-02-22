import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/sign_in_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/welcome/welcome_screen.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

// TODO: Update as per #152.
class SignInScreen extends StatelessWidget {
  // TODO: TextEditingControllers must be disposed of in State<T> of Stateful widgets
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  static const route = '/signIn';

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<SignInViewModel>(
      builder: (context, model, child) => BusyOverlayScreen(
        show: model.state == ViewState.Busy,
        child: Scaffold(
          appBar: AppBar(title: Text('Animal Transport Record App')),
          body: Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text(
                    'SIGN IN',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.0,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                    controller: emailController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                  ),
                  Text('Forgot Password?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.end),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50.0,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      model.signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                    },
                    child: Text('Sign In',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  TextButton(
                    child: Text('Go back to welcome screen'),
                    onPressed: () =>
                        _navigationService.navigateTo(WelcomeScreen.route),
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
