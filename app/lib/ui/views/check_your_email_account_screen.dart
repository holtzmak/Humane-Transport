import 'package:app/core/view_models/check_your_email_account_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class ConfirmationMessageScreen extends StatefulWidget {
  static const route = '/confirmationMsg';
  final formKey = GlobalKey<FormState>();

  ConfirmationMessageScreen({
    Key key,
  }) : super(key: key);

  @override
  _ConfirmationMessageScreenState createState() =>
      _ConfirmationMessageScreenState();
}

class _ConfirmationMessageScreenState extends State<ConfirmationMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<ConfirmationMessageModel>(
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
                  Padding(padding: EdgeInsets.all(1.0)),
                  Text(
                    'Check Your Email Account',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.0,
                    ),
                  ),
                  Text(
                    'You will receive a link to reset your password at your email account.',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.0,
                    ),
                  ),
                  Text(
                    'If you do not see the email within 12 hours, check your spam or junk folder before submitting a new request.',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.0,
                    ),
                  ),
                  TextButton(
                    child: Text('Click here to go to login page',
                        style: TextStyle(fontSize: 20)),
                    onPressed: () => model.navigateToSignInScreen(),
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
