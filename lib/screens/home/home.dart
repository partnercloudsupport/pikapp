import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pikapp/locale/localizations.dart';
import 'package:pikapp/widgets/buttons/review.dart';

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

    final localizations = AppLocalizations.of(context);

    _items = <HomeNavigationItem>[
      HomeNavigationItem(
        child: HomeTab(),
        icon: const Icon(Icons.home),
        title: localizations.translate('home_tab_title'),
        vsync: this,
        key: const PageStorageKey<String>('home'),
      ),
      HomeNavigationItem(
        child: ChannelTab(),
        icon: const Icon(FontAwesomeIcons.youtube),
        title: localizations.translate('channel_tab_title'),
        vsync: this,
        key: const PageStorageKey<String>('channel'),
      ),
      HomeNavigationItem(
        child: ShopTab(),
        icon: const Icon(Icons.store),
        title: localizations.translate('shop_tab_title'),
        vsync: this,
        key: const PageStorageKey<String>('shop'),
      ),
    ];

    // Set animation controller (opacity and scale) to make screen visible
    _items[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (var item in _items) item.controller.dispose();

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
    final title = AppLocalizations.of(context).translate('title');

    final appBar = AppBar(
      centerTitle: true,
      title: Text(title),
      leading: ReviewIconButton(),
      actions: <Widget>[HomeMenuButton()],
    );

    final navigationItems =
        _items.map((var item) => item.navigationItem).toList();

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
