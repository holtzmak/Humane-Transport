import 'package:app/core/models/firestore_user.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/signup_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const route = '/signup';
  final NavigationService _navigationService = locator<NavigationService>();

  SignUpScreen({
    Key key,
  }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _userPhoneNumberController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _userPhoneNumberController = TextEditingController();
    super.initState();
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userPhoneNumberController.dispose();
    super.dispose();
  }

  String emptyFieldValidation(value) {
    if (value.isEmpty) {
      return "* Required";
    } else
      return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 10) {
      return "Password should not be greater than 15 characters";
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
              appBar: AppBar(title: Text('Animal Transport Record App')),
              body: Center(
                  child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 40.0,
                            ),
                          ),
                          TextFormField(
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
                            child: Text('Already have an account?'),
                            onPressed: () => widget._navigationService
                                .navigateTo(SignInScreen.route),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20.0,
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                model.signUp(
                                  userEmailAddress:
                                      _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  userPhoneNumber:
                                      _userPhoneNumberController.text.trim(),
                                );
                              }
                            },
                            child: Text('Register',
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            color: Colors.green,
                          ),
                          Text(
                              'By creating an account you agree to our Terms of Service and Privacy Policy',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                              ),
                              textAlign: TextAlign.center),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 50.0,
                            ),
                          ),
                          TextButton(
                            child: Text('Go back to Welcome screen'),
                            onPressed: () => model.navigateToWelcomeScreen(),
                          ),
                        ],
                        // TODO: Account creation
                      ),
                    ),
                  ),
                ),
              )),
            )));
  }
}
