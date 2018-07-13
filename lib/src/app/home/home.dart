import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../../lib/firebase/remote_config.dart';
import './placeholder.dart';
import './scaffold.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with AfterLayoutMixin<AppHome> {
  bool _isLoading = true;
  bool _isError = false;

  void _onRefresh() async {
    setState(() {
      _isError = false;
    });

    try {
      await fetchRemoteConfig().timeout(Duration(seconds: 10));

      setState(() {
        _isLoading = false;
      });
    } catch (exception) {
      setState(() {
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedCrossFade(
        duration: kThemeAnimationDuration * 2.5,
        firstChild: AppPlaceholder(
            child: _isError
                ? Center(
                    child: Icon(
                    Icons.mood_bad,
                    color: Theme.of(context).accentColor,
                    size: 56.0,
                  ))
                : Center(child: CircularProgressIndicator())),
        secondChild: AppScaffold(),
        crossFadeState:
            _isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) => _onRefresh();
}
