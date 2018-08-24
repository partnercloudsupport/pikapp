import 'package:flutter/material.dart';

class AppPlaceholder extends StatelessWidget {
  const AppPlaceholder({@required this.child});

  final Widget child;

  static const BottomNavigationBarItem placeholderItem =
      BottomNavigationBarItem(
    icon: Icon(
      IconData(0),
      color: Colors.transparent,
    ),
    title: Text(''),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          items: List.filled(3, placeholderItem),
          onTap: null,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          heroTag: null,
        ),
      );
}
