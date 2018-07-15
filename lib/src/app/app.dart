import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../config/constants.dart';
import '../lib/firebase/analytics.dart';
import 'home.dart';
import 'locale/localizations.dart';

class App extends StatefulWidget {
  static AppData of(BuildContext context) =>
      context.ancestorStateOfType(TypeMatcher<AppData>());

  @override
  AppData createState() => AppData();
}

class AppData extends State<App> {
  static final List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static final navigatorObservers = [analyticsObserver];

  static final List<Locale> supportedLocales = [Locale('it'), Locale('en')];

  static Locale localeResolutionCallback(
      Locale locale, Iterable<Locale> supportedLocales) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  static String onGenerateTitle(BuildContext context) =>
      AppLocalizations.of(context).translate('title');

  Brightness brightness = Brightness.light;

  void setBrightness(Brightness brightness) {
    setState(() {
      this.brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      brightness: brightness,
      fontFamily: 'Nunito',
      primarySwatch: primaryColor,
      accentColor: brightness == Brightness.light ? null : primaryColor[200],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppHome(),
      localizationsDelegates: localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
      navigatorObservers: navigatorObservers,
      onGenerateTitle: onGenerateTitle,
      supportedLocales: supportedLocales,
      theme: theme,
    );
  }
}
