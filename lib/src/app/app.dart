import 'package:flutter/material.dart';

import 'home.dart';

class App extends StatelessWidget {
  final String title = 'PikApp';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(title: this.title),
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      title: this.title,
    );
  }
}
