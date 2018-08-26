import 'package:flutter/material.dart';

import 'package:pikapp/screens/home/home.dart';
import 'package:pikapp/services/firebase/remote_config.dart';

import 'placeholder.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  static Widget _buildLayout(Widget topChild, Key topChildKey,
          Widget bottomChild, Key bottomChildKey) =>
      Stack(
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

  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();

    _onLoading();
  }

  void _onLoading() async {
    setState(() {
      _isError = false;
    });

    try {
      await fetchRemoteConfig().timeout(Duration(seconds: 10));

      setState(() {
        _isLoading = false;
      });
    } on Exception catch (exception) {
      print(exception);
      setState(() {
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Widget child = _isError
        ? Center(
            child: Icon(
              Icons.sentiment_very_dissatisfied,
              color: theme.accentColor,
              size: 56.0,
            ),
          )
        // : Center(child: CircularProgressIndicator())),
        : Center(
            child: Image.asset('lib/resources/assets/icon.png', height: 48.0),
          );

    return Container(
      color: Colors.white,
      child: AnimatedCrossFade(
        duration: kThemeAnimationDuration * 2.5,
        firstChild: AppPlaceholder(
          child: child,
        ),
        secondChild: HomeScreen(),
        crossFadeState:
            _isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        layoutBuilder: _buildLayout,
      ),
    );
  }
}
