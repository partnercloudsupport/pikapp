import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../config/constants.dart';
import 'components/buttons/review.dart';
import 'floating_action_button.dart';
import 'locale/localizations.dart';
import 'navigation.dart';
import 'tabs/channel.dart';
import 'tabs/home.dart';
import 'tabs/shop.dart';

class HomePage extends StatelessWidget {
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

  static final List<Widget> _tabs = <Widget>[
    HomeTab(),
    ChannelTab(),
    ShopTab(),
  ];

  void _onSelected(dynamic value) => url_launcher.launch(value);

  @override
  Widget build(BuildContext context) {
    final String title = AppLocalizations.of(context).translate('title');

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
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
        body: TabBarView(
          children: _tabs,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: AppNavigationBar(),
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
      ),
    );
  }
}
