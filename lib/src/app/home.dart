import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'components/buttons/notifications.dart';
import 'components/buttons/review.dart';
import 'locale/localizations.dart';
import 'navigation.dart';
import 'tabs/channel.dart';
import 'tabs/home.dart';
import 'tabs/shop.dart';

class HomePage extends StatelessWidget {
  static final String url = 'https://urlgeni.us/fb_messenger/pikatea';

  final List<Widget> _children = <Widget>[
    HomeTab(),
    ChannelTab(),
    ShopTab(),
  ];

  void _onPressed() async {
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = AppLocalizations.of(context).translate('title');
    String tooltip = AppLocalizations.of(context).translate('fab_tooltip');

    return DefaultTabController(
      length: _children.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
          leading: ReviewIconButton(),
          actions: <Widget>[NotificationIconButton()],
        ),
        body: TabBarView(
          children: _children,
          physics: NeverScrollableScrollPhysics(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(FontAwesomeIcons.facebookMessenger),
          onPressed: _onPressed,
          tooltip: tooltip,
        ),
        bottomNavigationBar: NavigationBar(),
      ),
    );
  }
}
