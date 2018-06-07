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
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.red[600],
      icon: Icon(Icons.play_circle_filled),
      title: Text('Canale'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.orange[700],
      icon: Icon(Icons.store),
      title: Text('Negozio'),
    ),
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
      items: _items,
      onTap: _onTap,
    );
  }
}
