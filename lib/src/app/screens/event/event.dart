import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Event'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.mood_bad),
              Text('There\'s no events at the moment, try again tomorrow!'),
            ],
          ),
        ),
      );
}
