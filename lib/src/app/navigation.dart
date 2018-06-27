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
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ),
        item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        ) {
    final Interval interval = Interval(0.5, 1.0, curve: Curves.fastOutSlowIn);

    _opacity = CurvedAnimation(
      parent: controller,
      curve: interval,
    );

    _scale = Tween(begin: 0.97, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: interval,
      reverseCurve: Threshold(0.0),
    ));
  }

  final Widget _child;
  final AnimationController controller;
  final BottomNavigationBarItem item;

  CurvedAnimation _opacity;
  Animation<double> _scale;

  FadeTransition transition() {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
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
  int _currentIndex = 0;
  List<NavigationView> _views;

  static final List<PopupMenuItem> _items = <PopupMenuItem>[
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

    for (NavigationView view in _views) view.controller.addListener(_rebuild);

    _views[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationView view in _views) view.controller.dispose();

    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  void _onSelected(dynamic value) => url_launcher.launch(value);

  void _onTap(int index) {
    setState(() {
      _views[_currentIndex].controller.reverse();
      _currentIndex = index;
      _views[_currentIndex].controller.forward();
    });
  }

  Stack _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationView view in _views) transitions.add(view.transition());

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    final List<BottomNavigationBarItem> items =
        _views.map((NavigationView view) => view.item).toList();

    return BottomNavigationBar(
      items: items,
      currentIndex: _currentIndex,
      onTap: _onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String title = AppLocalizations.of(context).translate('title');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        leading: ReviewIconButton(),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: _onSelected,
            itemBuilder: (BuildContext context) => _items,
          ),
        ],
      ),
      body: Center(child: _buildTransitionsStack()),
      bottomNavigationBar: _buildBottomNavigationBar(),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: Text(title),
      //         decoration: BoxDecoration(color: Colors.pinkAccent),
      //       ),
      //       ListTile(
      //         title: Text('Item'),
      //         onTap: () {
      //           // Update the state of the app
      //           // ...
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: EventFloatingActionButton(),
    );
  }
}
