import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Event'),
        ),
        body: Center(
          child: Text('There\'s no events at the moment, try again tomorrow!'),
        ),
      );
}
