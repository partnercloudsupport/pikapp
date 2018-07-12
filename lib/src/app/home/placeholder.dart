import 'package:flutter/material.dart';

class AppPlaceholder extends StatelessWidget {
  static final BottomNavigationBarItem placeholderItem =
      BottomNavigationBarItem(
    icon: Icon(
      IconData(0),
      color: Colors.transparent,
    ),
    title: Text(''),
  );

  static final Scaffold placeholderScaffold = Scaffold(
    appBar: AppBar(),
    body: Center(child: CircularProgressIndicator()),
    bottomNavigationBar: BottomNavigationBar(
      items: [placeholderItem, placeholderItem],
      onTap: null,
    ),
    floatingActionButton: FloatingActionButton(onPressed: null),
  );

  @override
  Widget build(BuildContext context) => placeholderScaffold;
}
