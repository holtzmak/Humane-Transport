import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/sign_out_view_model.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/views/new/test_screens/test_screen_one.dart';
import 'package:app/ui/views/new/test_screens/test_screen_three.dart';
import 'package:app/ui/widgets/utility/image_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TODO: Update as per #134 and #119.
class NewScreen extends StatelessWidget {
  static const route = '${HomeScreen.route}/new';
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: TemplateBaseViewModel<SignOutViewModel>(
          builder: (context, model, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Testing feature for uploading image'),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(ImageScreen.route),
                child: Text('Upload Image'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Text('Go to test page with bottom nav'),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(TestScreenOne.route),
                child: Text('Go Next'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Text('Go to test page without bottom nav'),
              RaisedButton(
                onPressed: () =>
                    _navigationService.navigateTo(TestScreenThree.route),
                child: Text('Go Next'),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              RaisedButton(
                onPressed: () => model.signOut(),
                child: Text('Sign Out'),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
