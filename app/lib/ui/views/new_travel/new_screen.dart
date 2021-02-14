import 'package:app/core/view_models/sign_out_view_model.dart';
import 'package:app/ui/views/navigation_drawer.dart';
import 'package:app/ui/views/new_travel/test_screens/test_screen_one.dart';
import 'package:app/ui/widgets/utility/image_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TODO: Update as per #134 and #119.
class NewScreen extends StatelessWidget {
  static const route = '/home/new_travel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      drawer: NavigationDrawer(),
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
              SizedBox(
                height: 50.0,
              ),
              Text('Go to test page'),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(TestScreenOne.route),
                child: Text('Go Next'),
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                height: 50.0,
              ),
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
