import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../config/constants.dart';
import 'components/buttons/review.dart';
import 'floating_action_button.dart';
import 'locale/localizations.dart';
import 'tabs/channel.dart';
import 'tabs/home.dart';
import 'tabs/shop.dart';

class TabItem extends StatelessWidget {
  TabItem({
    @required Widget child,
    @required Icon icon,
    @required String title,
    @required TickerProvider vsync,
    Key key,
  })  : _child = child,
        controller = AnimationController(
          duration: Duration(milliseconds: 150),
          vsync: vsync,
        ),
        navigationItem = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        ),
        super(key: key);

  static final _curve = Curves.fastOutSlowIn;
  static final _reverseCurve = Threshold(0.0);

  final Animatable<double> _opacity =
      Tween(begin: 0.015, end: 1.0).chain(CurveTween(curve: _curve));

  final Animatable<double> _scale = Tween(begin: 0.97, end: 1.0);

  final Widget _child;

  final AnimationController controller;
  final BottomNavigationBarItem navigationItem;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity.animate(controller),
      child: ScaleTransition(
        scale: _scale.animate(CurvedAnimation(
          parent: controller,
          curve: _curve,
          reverseCurve: _reverseCurve,
        )),
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
  List<TabItem> _bodyItems;
  List<BottomNavigationBarItem> _navigationItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final AppLocalizations localizations = AppLocalizations.of(context);

    _bodyItems = <TabItem>[
      TabItem(
        child: HomeTab(),
        icon: Icon(Icons.home),
        title: localizations.translate('home_tab_title'),
        vsync: this,
        key: PageStorageKey<String>('home'),
      ),
      TabItem(
        child: ChannelTab(),
        icon: Icon(FontAwesomeIcons.youtube),
        title: localizations.translate('channel_tab_title'),
        vsync: this,
        key: PageStorageKey<String>('channel'),
      ),
      TabItem(
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
        _bodyItems.map((TabItem item) => item.navigationItem).toList();
  }

  @override
  void dispose() {
    for (TabItem item in _bodyItems) item.controller.dispose();

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
