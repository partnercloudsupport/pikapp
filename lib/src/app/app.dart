import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../lib/firebase/analytics.dart';
import 'home.dart';
import 'locale/localizations.dart';

class App extends StatelessWidget {
  App({@required this.theme});

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

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
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
