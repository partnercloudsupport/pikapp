import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import 'package:pikapp/locale/localizations.dart';
import 'package:pikapp/widgets/video_list.dart';

var _cachedData = Map<String, dynamic>.unmodifiable({});

class ChannelTab extends StatefulWidget {
  @override
  _ChannelTabState createState() => _ChannelTabState();
}

class _ChannelTabState extends State<ChannelTab>
    with AfterLayoutMixin<ChannelTab> {
  static final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  SnackBar get _snackBar {
    final localizations = AppLocalizations.of(context);

    return SnackBar(
      duration: Duration(seconds: 5),
      content: Text(localizations.translate('something_wrong')),
      action: SnackBarAction(
        label: localizations.translate('retry').toUpperCase(),
        onPressed: _refreshIndicatorKey.currentState?.show,
      ),
    );
  }

  Map<String, dynamic> _data = _cachedData;
  bool _isError = false;
  bool _isRefresh = false;

  void _onError() {
    setState(() {
      _isError = true;
      _isRefresh = false;
    });

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(_snackBar);
  }

  Future<Null> _onRefresh() async {
    setState(() {
      _isRefresh = true;
    });

    try {
      final Map response = await CloudFunctions.instance
          .call(functionName: 'getVideos')
          .timeout(Duration(seconds: 10));
      _cachedData = Map<String, dynamic>.unmodifiable(response);

      setState(() {
        _data = _cachedData;
        _isError = false;
      });

      Scaffold.of(context).removeCurrentSnackBar();
    } on Exception {
      _onError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final themeData = Theme.of(context);

    final items = List<Map>.unmodifiable(
      _data.containsKey('items') ? _data['items'] : [],
    );

    final child = _isError
        ? Center(
            child: RaisedButton.icon(
              color: themeData.accentColor,
              textColor: themeData.accentIconTheme.color,
              icon: const Icon(Icons.refresh),
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
