import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  final List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        backgroundColor: Colors.pink[300],
        icon: Icon(Icons.home),
        title: Text('Home')),
    BottomNavigationBarItem(
        backgroundColor: Colors.red[600],
        icon: Icon(Icons.play_circle_filled),
        title: Text('Channel')),
    BottomNavigationBarItem(
        backgroundColor: Colors.orange[700],
        icon: Icon(Icons.shopping_basket),
        title: Text('Shop')),
    BottomNavigationBarItem(
        backgroundColor: Colors.indigo[400],
        icon: Icon(Icons.info),
        title: Text('Info'))
  ];

  int _currentIndex = 0;

  _onTap(int index) {
    /// Animating to the index.
    /// You can use whatever duration and curve you like
    TabController controller = DefaultTabController.of(context);
    controller.animateTo(index,
        duration: const Duration(milliseconds: 350),
        curve: Curves.fastOutSlowIn);

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTap,
      items: _items,
    );
  }
}
