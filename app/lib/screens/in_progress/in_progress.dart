import 'package:flutter/material.dart';

class InProgress extends StatelessWidget {
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
