import 'package:flutter/material.dart';

class OngoingTravel extends StatelessWidget {
  static const route = '/ongoing';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('Ongoing travel'),
      ),
    );
  }
}
