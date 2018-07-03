import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../../lib/youtube.dart';
import '../components/video_list.dart';
import '../locale/localizations.dart';

class ChannelTab extends StatefulWidget {
  @override
  _ChannelTabState createState() => _ChannelTabState();
}

class _ChannelTabState extends State<ChannelTab>
    with AfterLayoutMixin<ChannelTab> {
  static final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  SnackBar get _snackBar {
    AppLocalizations localizations = AppLocalizations.of(context);
    return SnackBar(
      duration: Duration(seconds: 10),
      content: Text(localizations.translate('text_something_wrong')),
      action: SnackBarAction(
        label: localizations.translate('text_retry').toUpperCase(),
        onPressed: _refreshIndicatorKey.currentState?.show,
      ),
    );
  }

  Map<String, dynamic> _data = YoutubeApi.data;

  Future<Null> _onRefresh() async {
    try {
      Map<String, dynamic> data = await YoutubeApi.fetchData();

      setState(() {
        _data = data;
      });
    } catch (error) {
      Scaffold.of(context).showSnackBar(_snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    List items = _data.containsKey('items') ? _data['items'] : [];

    return RefreshIndicator(
      child: VideoList(items),
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (!_data.containsKey('items')) _refreshIndicatorKey.currentState?.show();
  }
}
