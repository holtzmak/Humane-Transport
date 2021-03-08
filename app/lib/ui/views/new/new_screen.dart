import 'package:app/core/view_models/new_screen_view_model.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TODO: Update as per #134 and #119.
class NewScreen extends StatelessWidget {
  static const route = '/new';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(
                Icons.logout,
                size: 26.0,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: TemplateBaseViewModel<NewScreenViewModel>(
          builder: (context, model, child) => Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1501630834273-4b5604d2ee31?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OXx8c2t5fGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80'),
                  ),
                  Positioned(
                      bottom: 20.0,
                      left: 10.0,
                      child: Text(
                        'John Doe',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      )),
                  Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      child: Text(
                        'Regina, SK',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0),
                      )),
                  Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.blueGrey,
                        onPressed: () {},
                      )),
                  Positioned(
                      child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1544393569-eb1568319eef?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c3RvcHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
                  ))
                ],
              ),
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10.0),
                children: <Widget>[
                  RaisedButton.icon(
                    onPressed: model.startNewAtr,
                    padding: EdgeInsets.all(30.0),
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    color: Colors.orange,
                    label: Text(
                      'New Form',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                  ),
                  RaisedButton.icon(
                    onPressed: model.startNewAtr,
                    padding: EdgeInsets.all(30.0),
                    icon: Icon(
                      Icons.wifi_protected_setup,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    color: Colors.orange,
                    label: Text(
                      'Active Form',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                  ),
                  RaisedButton.icon(
                    onPressed: model.startNewAtr,
                    padding: EdgeInsets.all(30.0),
                    icon: Icon(
                      Icons.history_sharp,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    color: Colors.orange,
                    label: Text(
                      'Travel History',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                  ),
                  RaisedButton.icon(
                    onPressed: model.signOut,
                    padding: EdgeInsets.all(30.0),
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    color: Colors.orange,
                    label: Text(
                      'Log Out',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
