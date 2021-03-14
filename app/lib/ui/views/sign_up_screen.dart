import 'package:app/core/view_models/signup_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/common/style.dart';
import 'package:hexcolor/hexcolor.dart';

class SignUpScreen extends StatefulWidget {
  static const route = '/signup';
  final formKey = GlobalKey<FormState>();

  SignUpScreen({
    Key key,
  }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userPhoneNumberController =
      TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userPhoneNumberController.dispose();
    super.dispose();
  }

  // TODO: Extract validators into their own service
  String emptyFieldValidation(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else
      return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be at least 6 characters";
    } else if (value.length > 10) {
      return "Password should not be greater than 10 characters";
    } else
      return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return '* Required';
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return '* Please enter a valid Email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<SignUpViewModel>(
        builder: (context, model, child) => BusyOverlayScreen(
            show: model.state == ViewState.Busy,
            child: Scaffold(
                appBar: appBar('Humane Transport App'),
                body: Center(
                  child: SingleChildScrollView(
                      child: Form(
                    key: widget.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.all(5.0)),
                            Text(
                              'Create An Account',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: buttonColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 40.0,
                              ),
                            ),
                            TextFormField(
                              key: ObjectKey("First Name"),
                              validator: emptyFieldValidation,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "First Name"),
                              controller: _firstNameController,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                            ),
                            TextFormField(
                              key: ObjectKey("Last Name"),
                              validator: emptyFieldValidation,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Last Name"),
                              controller: _lastNameController,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                            ),
                            TextFormField(
                              key: ObjectKey("Email"),
                              validator: validateEmail,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Email"),
                              controller: _emailController,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                            ),
                            TextFormField(
                              // TODO: Obscure the password on demand in future
                              key: ObjectKey("Password"),
                              validator: validatePassword,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Password"),
                              controller: _passwordController,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                            ),
                            TextFormField(
                              key: ObjectKey("Phone Number"),
                              controller: _userPhoneNumberController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Phone Number"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0.5,
                              ),
                            ),
                            TextButton(
                              child: Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#8C8146'),
                                ),
                              ),
                              onPressed: () => model.navigateToSignInScreen(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                            ),
                            SizedBox(
                                height: 42,
                                width: 200,
                                child: RaisedButton(
                                  onPressed: () {
                                    if (widget.formKey.currentState
                                        .validate()) {
                                      model.signUp(
                                        userEmailAddress:
                                            _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                        firstName:
                                            _firstNameController.text.trim(),
                                        lastName:
                                            _lastNameController.text.trim(),
                                        userPhoneNumber:
                                            _userPhoneNumberController.text
                                                .trim(),
                                      );
                                    }
                                  },
                                  child: Text('Register',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                  color: buttonColor,
                                )),
                            Text(
                                'By creating an account you agree to our Terms of Service and Privacy Policy',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 30.0,
                              ),
                            ),
                            TextButton(
                              child: Text(
                                'Go back to Welcome screen',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#8C8146'),
                                ),
                              ),
                              onPressed: () => model.navigateToWelcomeScreen(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ))));
  }
}
