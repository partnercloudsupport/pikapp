import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../config/constants.dart';
import 'components/buttons/review.dart';
import 'floating_action_button.dart';
import 'locale/localizations.dart';
import 'tabs/channel.dart';
import 'tabs/home.dart';
import 'tabs/shop.dart';

class NavigationView {
  NavigationView({
    @required Widget child,
    @required Icon icon,
    @required String title,
    @required TickerProvider vsync,
  })  : _child = child,
        controller = AnimationController(
          duration: kThemeAnimationDuration * 0.5,
          vsync: vsync,
        ),
        item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        ) {
    final Curve _curve = Curves.fastOutSlowIn;

    _opacity = Tween(begin: 0.01, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: _curve,
    ));

    _scale = Tween(begin: 0.97, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: _curve,
      reverseCurve: Threshold(0.0),
    ));
  }

  final Widget _child;
  final AnimationController controller;
  final BottomNavigationBarItem item;

  Animation<double> _opacity;
  Animation<double> _scale;

  Widget transition() {
    return _child;
    // return FadeTransition(
    //   opacity: _opacity,
    //   child: ScaleTransition(
    //     scale: _scale,
    //     child: _child,
    //   ),
    // );
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
  List<NavigationView> _views;
  List<BottomNavigationBarItem> _navigationItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final AppLocalizations localizations = AppLocalizations.of(context);

    _views = <NavigationView>[
      NavigationView(
        child: HomeTab(),
        icon: Icon(Icons.home),
        title: localizations.translate('home_tab_title'),
        vsync: this,
      ),
      NavigationView(
        child: ChannelTab(),
        icon: Icon(Icons.play_circle_filled),
        title: localizations.translate('channel_tab_title'),
        vsync: this,
      ),
      NavigationView(
        child: ShopTab(),
        icon: Icon(Icons.store),
        title: localizations.translate('shop_tab_title'),
        vsync: this,
      ),
    ];

    // Set animation controller (opacity and scale) to make screen visible
    _views[_currentIndex].controller.value = 1.0;

    _navigationItems = _views.map((NavigationView view) => view.item).toList();
  }

  @override
  void dispose() {
    for (NavigationView view in _views) view.controller.dispose();

    super.dispose();
  }

  void _onSelected(dynamic value) => url_launcher.launch(value);

  void _onTap(int index) async {
    // Wait for the old screen transition to complete
    await _views[_currentIndex].controller.reverse();

    // Then update the index and animate the screen
    setState(() {
      _currentIndex = index;
      _views[_currentIndex].controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String title = AppLocalizations.of(context).translate('title');
    final SliverAppBar appBar = SliverAppBar(
      centerTitle: true,
      title: Text(title),
      leading: ReviewIconButton(),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: _onSelected,
          itemBuilder: (BuildContext context) => _menuItems,
        ),
      ],
      floating: true,
      snap: true,
      forceElevated: true,
    );
    final Widget body = _views[_currentIndex].transition();

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
      floatingActionButton: EventFloatingActionButton(),
      body: CustomScrollView(slivers: <Widget>[appBar, body]),
    );
  }
}
