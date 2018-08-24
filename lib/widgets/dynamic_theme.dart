import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// typedef Widget DynamicThemeBuilder(BuildContext context, ThemeData data);
typedef DynamicThemeBuilder = Widget Function(
    BuildContext context, Brightness brightness);

class DynamicTheme extends StatefulWidget {
  final DynamicThemeBuilder builder;

  final ThemeData defaultTheme;

  const DynamicTheme({Key key, this.builder, this.defaultTheme})
      : super(key: key);

  @override
  DynamicThemeState createState() => DynamicThemeState();

  static DynamicThemeState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<DynamicThemeState>());
}

class DynamicThemeState extends State<DynamicTheme> {
  static const _brightnessKey = "isDark";

  // ThemeData _data;
  Brightness _data;

  @override
  void initState() {
    super.initState();

    // _data = widget.defaultTheme;
    _data = widget.defaultTheme.brightness;

    _getBrightness();
  }

  void _getBrightness() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_brightnessKey);

    if (isDark != null) {
      setState(() {
        _data = isDark ? Brightness.dark : Brightness.light;
      });
    }
  }

  void setBrightness(Brightness brightness) async {
    setState(() {
      // _data = _data.copyWith(brightness: brightness);
      _data = brightness;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_brightnessKey, brightness == Brightness.dark);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _data);
}
