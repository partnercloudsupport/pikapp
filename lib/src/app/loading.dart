import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../lib/firebase/remote_config.dart';
import './app.dart';

class AppLoading extends StatelessWidget {
  Widget _buildStack(Widget topChild, Key topChildKey, Widget bottomChild,
          Key bottomChildKey) =>
      Stack(
        textDirection: TextDirection.ltr,
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
          ),
        ],
      );

  Widget _buildContainer(BuildContext context, AsyncSnapshot snapshot) {
    Widget firstChild = Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(primaryColor),
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
            color: Colors.white,
            child: Center(
              child: Icon(
                Icons.mood_bad,
                color: primaryColor,
                size: 56.0,
              ),
            ),
          );
        else
          secondChild = App();

        break;
    }

    return Container(
      color: Colors.white,
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
      future: fetchRemoteConfig(),
      builder: _buildContainer,
    );
  }
}
