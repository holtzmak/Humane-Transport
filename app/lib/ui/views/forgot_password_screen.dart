import 'package:app/core/view_models/forgot_password_view_model.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const route = '/forgotPWD';
  final formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({
    Key key,
  }) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String emptyFieldValidation(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<ForgotPasswordViewModel>(
        builder: (context, model, child) => BusyOverlayScreen(
            show: model.state == ViewState.Busy,
            child: Scaffold(
              appBar: appBar('Humane Transport App'),
              body: Padding(
                padding: const EdgeInsets.all(40),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: widget.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.all(5.0)),
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 24,
                                color: NavyBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 40.0,
                            ),
                          ),
                          TextFormField(
                            key: ObjectKey("Email"),
                            validator: emptyFieldValidation,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email"),
                            controller: emailController,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20.0,
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (widget.formKey.currentState.validate()) {
                                model.resetPassword(
                                    email: emailController.text.trim());
                              }
                            },
                            child: Text('Reset Password',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            color: NavyBlue,
                          ),
                          SizedBox(
                            height: 100.0,
                          ),
                          TextButton(
                            child: Text(
                              'Click here to go to login page',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: HexColor('#8C8146'),
                              ),
                            ),
                            onPressed: () => model.navigateToSignInScreen(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
