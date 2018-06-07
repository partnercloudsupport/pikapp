import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'components/buttons/notifications.dart';
import 'components/buttons/review.dart';

import 'tabs/channel.dart';
import 'tabs/home.dart';
import 'tabs/shop.dart';

import 'navigation.dart';

class HomePage extends StatelessWidget {
  static final String url = "https://www.messenger.com/t/pikateachannel";

  final String title;

  HomePage({@required String this.title, Key key}) : super(key: key);

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
          child: Icon(Icons.chat_bubble),
          onPressed: _onPressed,
          tooltip: 'Chat with me!',
        ),
        bottomNavigationBar: NavigationBar(),
      ),
    );
  }
}
