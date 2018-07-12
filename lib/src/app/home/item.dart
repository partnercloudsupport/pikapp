import 'package:flutter/material.dart';

class AppItem extends StatelessWidget {
  AppItem({
    @required Widget child,
    @required Icon icon,
    @required String title,
    @required TickerProvider vsync,
    Key key,
  })  : _child = child,
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ),
        navigationItem = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        ),
        super(key: key);

  static final _curve = Curves.fastOutSlowIn;
  static final _reverseCurve = Threshold(0.0);

  final Animatable<double> _opacity =
      Tween(begin: 0.015, end: 1.0).chain(CurveTween(curve: _curve));

  final Animatable<double> _scale = Tween(begin: 0.97, end: 1.0);

  final Widget _child;

  final AnimationController controller;
  final BottomNavigationBarItem navigationItem;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity.animate(controller),
      child: ScaleTransition(
        scale: _scale.animate(CurvedAnimation(
          parent: controller,
          curve: _curve,
          reverseCurve: _reverseCurve,
        )),
        child: _child,
      ),
    );
  }
}
