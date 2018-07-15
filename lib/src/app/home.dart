import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../lib/firebase/remote_config.dart';
import 'placeholder.dart';
import 'screens/home/home.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with AfterLayoutMixin<AppHome> {
  static Widget _buildLayout(Widget topChild, Key topChildKey,
      Widget bottomChild, Key bottomChildKey) {
    return Stack(
      children: <Widget>[
        Positioned(
          key: bottomChildKey,
          left: 0.0,
          top: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: bottomChild,
        ),
        Positioned(
          key: topChildKey,
          child: topChild,
        )
      ],
    );
  }

  bool _isLoading = true;
  bool _isError = false;

  void _onLoading() async {
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
    final ThemeData theme = Theme.of(context);

    return Container(
      color: Colors.white,
      child: AnimatedCrossFade(
        duration: kThemeAnimationDuration * 2.5,
        firstChild: AppPlaceholder(
            child: _isError
                ? Center(
                    child: Icon(
                    Icons.mood_bad,
                    color: theme.accentColor,
                    size: 56.0,
                  ))
                : Center(child: CircularProgressIndicator())),
        secondChild: HomeScreen(),
        crossFadeState:
            _isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        layoutBuilder: _buildLayout,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) => _onLoading();
}
