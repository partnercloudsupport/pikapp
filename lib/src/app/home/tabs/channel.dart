import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../../../lib/videos.dart';
import '../../components/video_list.dart';
import '../../locale/localizations.dart';

class ChannelTab extends StatefulWidget {
  @override
  _ChannelTabState createState() => _ChannelTabState();
}

class _ChannelTabState extends State<ChannelTab>
    with AfterLayoutMixin<ChannelTab> {
  static final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  SnackBar get _snackBar {
    final AppLocalizations localizations = AppLocalizations.of(context);

    return SnackBar(
      duration: Duration(seconds: 5),
      content: Text(localizations.translate('something_wrong')),
      action: SnackBarAction(
        label: localizations.translate('retry').toUpperCase(),
        onPressed: _refreshIndicatorKey.currentState?.show,
      ),
    );
  }

  Map<String, dynamic> _data = VideosApi.data;
  bool _isError = false;
  bool _isRefresh = false;

  void _onError() {
    setState(() {
      _isError = true;
      _isRefresh = false;
    });

    ScaffoldState scaffold = Scaffold.of(context);
    scaffold.removeCurrentSnackBar();
    scaffold.showSnackBar(_snackBar);
  }

  Future<Null> _onRefresh() async {
    setState(() {
      _isRefresh = true;
    });

    try {
      Map<String, dynamic> data =
          await VideosApi.fetchData().timeout(Duration(seconds: 10));

      setState(() {
        _data = data;
        _isError = false;
      });

      Scaffold.of(context).removeCurrentSnackBar();
    } catch (exception) {
      _onError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);

    final List items = _data.containsKey('items') ? _data['items'] : [];
    final Widget child = _isError
        ? Center(
            child: RaisedButton.icon(
              color: themeData.accentColor,
              textColor: themeData.accentIconTheme.color,
              icon: Icon(Icons.refresh),
              label: Text(localizations.translate('retry').toUpperCase()),
              onPressed:
                  _isRefresh ? null : _refreshIndicatorKey.currentState?.show,
            ),
          )
        : VideoList(items);

    return RefreshIndicator(
      child: child,
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (!_data.containsKey('items')) _refreshIndicatorKey.currentState?.show();
  }
}
