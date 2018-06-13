import 'package:flutter/material.dart';

import 'locale/localizations.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
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
    final AppLocalizations localizations = AppLocalizations.of(context);
    final List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text(localizations.translate('home_tab_title')),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.play_circle_filled),
        title: Text(localizations.translate('channel_tab_title')),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.store),
        title: Text(localizations.translate('shop_tab_title')),
      ),
    ];

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: items,
      onTap: _onTap,
    );
  }
}
