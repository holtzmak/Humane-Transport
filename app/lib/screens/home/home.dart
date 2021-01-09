import 'package:app/navbar/navigation.dart';
import 'package:app/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This is Home Page'),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationBarController(),
                ),
              );
            },
            icon: Icon(Icons.add_circle_outline),
            label: Text('New Travel'),
          ),
        ],
      )),
    );
  }
}
