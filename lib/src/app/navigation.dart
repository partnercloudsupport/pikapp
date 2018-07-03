import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../config/constants.dart';
import 'components/buttons/review.dart';
import 'floating_action_button.dart';
import 'locale/localizations.dart';
import 'tabs/channel.dart';
import 'tabs/home.dart';
import 'tabs/shop.dart';

class NavigationItem extends StatelessWidget {
  NavigationItem({
    Key key,
    @required Icon icon,
    @required String title,
    @required TickerProvider vsync,
    @required Widget child,
  })  : _child = child,
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ),
        item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        ),
        super(key: key);

  final Animatable<double> _opacity = Tween(begin: 0.015, end: 1.0)
      .chain(CurveTween(curve: Curves.fastOutSlowIn));

  final Animatable<double> _scale = Tween(begin: 0.97, end: 1.0)
      .chain(CurveTween(curve: Curves.fastOutSlowIn));

  final Widget _child;
  final AnimationController controller;
  final BottomNavigationBarItem item;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity.animate(controller),
      child: ScaleTransition(
        scale: _scale.animate(controller),
        child: _child,
      ),
    );
  }
}

class AppNavigation extends StatefulWidget {
  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation>
    with TickerProviderStateMixin<AppNavigation> {
  static final List<PopupMenuItem> _menuItems = <PopupMenuItem>[
    PopupMenuItem(
      value: donateUrl,
      child: Text('Donate'),
    ),
    PopupMenuItem(
      value: storeAndroidUrl,
      child: Text('Send Feedback'),
    ),
    // PopupMenuItem(
    //   child: Text('Info'),
    // ),
  ];

  int _currentIndex = 0;
  List<NavigationItem> _bodyItems;
  List<BottomNavigationBarItem> _navigationItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final AppLocalizations localizations = AppLocalizations.of(context);

    _bodyItems = <NavigationItem>[
      NavigationItem(
        key: PageStorageKey<String>('home'),
        child: HomeTab(),
        icon: Icon(Icons.home),
        title: localizations.translate('home_tab_title'),
        vsync: this,
      ),
      NavigationItem(
        key: PageStorageKey<String>('channel'),
        child: ChannelTab(),
        icon: Icon(Icons.play_circle_filled),
        title: localizations.translate('channel_tab_title'),
        vsync: this,
      ),
      NavigationItem(
        key: PageStorageKey<String>('shop'),
        child: ShopTab(),
        icon: Icon(Icons.store),
        title: localizations.translate('shop_tab_title'),
        vsync: this,
      ),
    ];

    // Set animation controller (opacity and scale) to make screen visible
    _bodyItems[_currentIndex].controller.value = 1.0;

    _navigationItems =
        _bodyItems.map((NavigationItem item) => item.item).toList();
  }

  @override
  void dispose() {
    for (NavigationItem item in _bodyItems) item.controller.dispose();

    super.dispose();
  }

  void _onSelected(dynamic value) => url_launcher.launch(value);

  void _onTap(int index) async {
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
      actions: <Widget>[
        PopupMenuButton(
          onSelected: _onSelected,
          itemBuilder: (BuildContext context) => _menuItems,
        ),
      ],
    );

    final Widget body = _bodyItems[_currentIndex];

    final BottomNavigationBar navigationBar = BottomNavigationBar(
      currentIndex: _currentIndex,
      items: _navigationItems,
      onTap: _onTap,
    );

    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: navigationBar,
      floatingActionButton: EventFloatingActionButton(),
    );
  }
}
