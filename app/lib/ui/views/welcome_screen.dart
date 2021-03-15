import 'package:app/core/view_models/welcome_screen_view_model.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  final String title;

  WelcomeScreen({Key key, this.title}) : super(key: key);
  static const route = '/welcome';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TemplateBaseViewModel<WelcomeScreenViewModel>(
        builder: (context, model, child) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/welcome_screen.jpg',
            ),
            Padding(padding: EdgeInsets.all(20)),
            Container(
              padding: EdgeInsets.all(30),
              alignment: Alignment.center,
              width: size.width,
              child: Column(
                children: [
                  Text(
                    'Welcome to Humane Transport Mobile Application',
                    style: GoogleFonts.alike(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: LargeTextSize,
                            height: 1.6,
                            color: HexColor("#0D0D0D"))),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40),
                  ),
                  Row(
                    children: [
                      ButtonTheme(
                        minWidth: size.width * 0.35,
                        padding: EdgeInsets.all(20),
                        buttonColor: NavyBlue,
                        child: RaisedButton(
                          onPressed: model.navigateToSignInScreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 30)),
                      ButtonTheme(
                        minWidth: size.width * 0.35,
                        padding: EdgeInsets.all(20),
                        buttonColor: HexColor('#143959'),
                        child: RaisedButton(
                          onPressed: model.navigateToSignUpScreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
