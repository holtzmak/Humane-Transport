import 'package:flutter/material.dart';

class InProgress extends StatefulWidget {
  @override
  _InProgressState createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('In progress');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back to Home'),
      ),
      body: Center(
        child: Text('This is progress page'),
      ),
    );
  }
}
