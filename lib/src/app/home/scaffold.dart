import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/buttons/review.dart';
import '../locale/localizations.dart';
import './fab.dart';
import './item.dart';
import './menu.dart';
import './tabs/channel.dart';
import './tabs/home.dart';
import './tabs/shop.dart';

class AppScaffold extends StatefulWidget {
  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold>
    with TickerProviderStateMixin<AppScaffold> {
  int _currentIndex = 0;
  List<AppItem> _bodyItems;
  List<BottomNavigationBarItem> _navigationItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final AppLocalizations localizations = AppLocalizations.of(context);

    _bodyItems = <AppItem>[
      AppItem(
        child: HomeTab(),
        icon: Icon(Icons.home),
        title: localizations.translate('home_tab_title'),
        vsync: this,
        key: PageStorageKey<String>('home'),
      ),
      AppItem(
        child: ChannelTab(),
        icon: Icon(FontAwesomeIcons.youtube),
        title: localizations.translate('channel_tab_title'),
        vsync: this,
        key: PageStorageKey<String>('channel'),
      ),
      AppItem(
        child: ShopTab(),
        icon: Icon(Icons.store),
        title: localizations.translate('shop_tab_title'),
        vsync: this,
        key: PageStorageKey<String>('shop'),
      ),
    ];

    // Set animation controller (opacity and scale) to make screen visible
    _bodyItems[_currentIndex].controller.value = 1.0;

    _navigationItems =
        _bodyItems.map((AppItem item) => item.navigationItem).toList();
  }

  @override
  void dispose() {
    for (AppItem item in _bodyItems) item.controller.dispose();

    super.dispose();
  }

  void _onTap(int index) async {
    if (index == _currentIndex) return;

    // Wait for the old screen transition to complete
    await _bodyItems[_currentIndex].controller.reverse();

    // Then update the index and animate the screen
    setState(() {
      _currentIndex = index;
      _bodyItems[_currentIndex].controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String title = AppLocalizations.of(context).translate('title');

    final AppBar appBar = AppBar(
      centerTitle: true,
      title: Text(title),
      leading: ReviewIconButton(),
      actions: <Widget>[AppMenuButton()],
    );

    return Scaffold(
      appBar: appBar,
      body: _bodyItems[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _navigationItems,
        onTap: _onTap,
      ),
      floatingActionButton: AppFloatingActionButton(),
    );
  }
}
