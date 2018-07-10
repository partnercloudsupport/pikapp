import 'dart:async';

import 'package:flutter/material.dart';

import '../lib/sentry.dart';
import '../lib/firebase/remote_config.dart';
import './navigation.dart';

Future<void> _setupApp() async {
  setupSentry();
  await setupRemoteConfig();

  // await Future.delayed(Duration(seconds: 1));
}

class AppLoading extends StatelessWidget {
  Widget _buildStack(Widget topChild, Key topChildKey, Widget bottomChild,
          Key bottomChildKey) =>
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

  Widget _buildContainer(BuildContext context, AsyncSnapshot snapshot) {
    final Color color = Theme.of(context).primaryColor;

    Widget firstChild = Container(
      color: color,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
    Widget secondChild = Container();
    CrossFadeState crossFadeState = CrossFadeState.showFirst;

    switch (snapshot.connectionState) {
      case ConnectionState.none:
        break;
      case ConnectionState.waiting:
        break;
      default:
        crossFadeState = CrossFadeState.showSecond;

        if (snapshot.hasError)
          secondChild = Container(
            color: color,
            child: Center(
              child: Icon(
                Icons.mood_bad,
                color: Colors.white,
                size: 56.0,
              ),
            ),
          );
        else
          secondChild = AppNavigation();

        break;
    }

    return Container(
      color: color,
      child: AnimatedCrossFade(
        duration: kThemeAnimationDuration * 2.5,
        firstChild: firstChild,
        secondChild: secondChild,
        crossFadeState: crossFadeState,
        layoutBuilder: _buildStack,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _setupApp(),
      builder: _buildContainer,
    );
  }
}
