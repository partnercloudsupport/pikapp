import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/buttons/review.dart';
import '../../locale/localizations.dart';
import 'fab.dart';
import 'item.dart';
import 'menu.dart';
import 'tabs/channel.dart';
import 'tabs/home.dart';
import 'tabs/shop.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen> {
  int _currentIndex = 0;
  List<HomeNavigationItem> _items;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final AppLocalizations localizations = AppLocalizations.of(context);

    _items = <HomeNavigationItem>[
      HomeNavigationItem(
        child: HomeTab(),
        icon: Icon(Icons.home),
        title: localizations.translate('home_tab_title'),
        vsync: this,
        key: PageStorageKey<String>('home'),
      ),
      HomeNavigationItem(
        child: ChannelTab(),
        icon: Icon(FontAwesomeIcons.youtube),
        title: localizations.translate('channel_tab_title'),
        vsync: this,
        key: PageStorageKey<String>('channel'),
      ),
      HomeNavigationItem(
        child: ShopTab(),
        icon: Icon(Icons.store),
        title: localizations.translate('shop_tab_title'),
        vsync: this,
        key: PageStorageKey<String>('shop'),
      ),
    ];

    // Set animation controller (opacity and scale) to make screen visible
    _items[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (HomeNavigationItem item in _items) item.controller.dispose();

    super.dispose();
  }

  void _onTap(int index) async {
    if (index == _currentIndex) return;

    // Wait for the old screen transition to complete
    await _items[_currentIndex].controller.reverse();

    // Then update the index and animate the screen
    setState(() {
      _currentIndex = index;
    });

    _items[_currentIndex].controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final String title = AppLocalizations.of(context).translate('title');

    final AppBar appBar = AppBar(
      centerTitle: true,
      title: Text(title),
      leading: ReviewIconButton(),
      actions: <Widget>[HomeMenuButton()],
    );

    final List<BottomNavigationBarItem> navigationItems =
        _items.map((HomeNavigationItem item) => item.navigationItem).toList();

    return Scaffold(
      appBar: appBar,
      body: _items[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: navigationItems,
        onTap: _onTap,
      ),
      floatingActionButton: HomeFab(),
    );
  }
}
