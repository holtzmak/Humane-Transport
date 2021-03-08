import 'package:app/core/view_models/splash_screen_view_model.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key key}) : super(key: key);
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TemplateBaseViewModel<SplashScreenViewModel>(
      onModelReady: (model) => model.handleStartLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "assets/splash_screen.png",
                height: size.height * 0.3,
                width: size.width * 0.3,
              ),
              SizedBox(
                height: 100,
              ),
              CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).buttonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
