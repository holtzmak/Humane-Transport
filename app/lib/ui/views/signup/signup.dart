import 'package:app/core/view_models/signup_view_model.dart';
import 'package:app/ui/views/base_view.dart';
import 'package:app/ui/widgets/busy_overlay.dart';
import 'package:app/ui/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userPhoneNumberController =
      TextEditingController();
  static const route = '/signup';
  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: Scaffold(
          appBar: AppBar(),
          drawer: SideBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign up'),
                  TextFormField(
                    decoration: InputDecoration(hintText: "First Name"),
                    controller: firstNameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Last Name"),
                    controller: lastNameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Email"),
                    controller: emailController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Password"),
                    controller: passwordController,
                  ),
                  TextFormField(
                    controller: userPhoneNumberController,
                    decoration: InputDecoration(hintText: "Phone Number"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      model.signUp(
                        userEmailAddress: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        userPhoneNumber: userPhoneNumberController.text.trim(),
                      );
                    },
                    child: Text('Register'),
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  RaisedButton(
                      child: Text('Go back to welcome screen'),
                      color: Colors.red,
                      onPressed: () => model.popScreen()),
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
