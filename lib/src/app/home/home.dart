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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedCrossFade(
        duration: kThemeAnimationDuration * 2.5,
        firstChild: AppPlaceholder(),
        secondChild: AppScaffold(),
        crossFadeState:
            _isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    await fetchRemoteConfig();

    setState(() {
      _isLoading = false;
    });
  }
}
